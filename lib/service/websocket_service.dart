import 'dart:async';

import 'package:ebbot_dart_client/configuration/configuration.dart';
import 'package:ebbot_dart_client/entity/button_data/button_data.dart';
import 'package:ebbot_dart_client/entity/chat/chat.dart';
import 'package:ebbot_dart_client/entity/chat_config/chat_config.dart';
import 'package:ebbot_dart_client/entity/fileupload/image_response.dart';
import 'package:ebbot_dart_client/entity/message/message.dart';
import 'package:ebbot_dart_client/service/log_service.dart';
import 'package:ebbot_dart_client/src/ebbot_chat_listener.dart';
import 'package:ebbot_dart_client/src/network/asyngular_websocket_client.dart';
import 'package:ebbot_dart_client/util/time_extension.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:socketcluster_client/socketcluster_client.dart';
import 'package:uuid/uuid.dart';

class WebSocketService {
  final String _botId;
  final String _chatId;
  final Configuration _configuration;
  late Logger? _logger;
  late Socket _socket;
  late AsyngularWebsocketClient _asyngularWebsocketClient;
  late EbbotChatListener _chatListener;

  get _messageStreamController => _chatListener.messageStreamController;
  get _chatStreamController => _chatListener.chatStreamController;

  bool _firstEventSent = false;

  Stream<Message> get messageStream =>
      _chatListener.messageStreamController.stream;
  Stream<Chat> get chatStream => _chatListener.chatStreamController.stream;

  WebSocketService(this._botId, this._chatId, this._configuration) {
    _logger = GetIt.I<LogService>().logger;
    _chatListener = _createChatListener();
  }

  Future<void> connect(String token) async {
    _logger?.i("Connecting to websocket service");
    _asyngularWebsocketClient = _createAsyngularWebsocketClient();
    _firstEventSent = false;

    _socket = await _asyngularWebsocketClient.initSocket(token, _chatListener);
    await _chatListener.onSubscribed();
  }

  EbbotChatListener _createChatListener() {
    return EbbotChatListener(
      _chatId,
    );
  }

  AsyngularWebsocketClient _createAsyngularWebsocketClient() {
    return AsyngularWebsocketClient(
      _botId,
      _chatId,
      _configuration.environment,
    );
  }

  Future<void> closeAsync({bool closeSocket = false}) async {
    _logger?.i("Closing chat client socket");

    sendCloseChatMessage();

    if (closeSocket == true) {
      _logger?.i("Socket has been initialized, closing it");
      _socket.unsubscribe("request.chat");
      _socket.closeWebsocket();
    }

    await _chatListener.reinitStreamControllersr();
  }

  void sendTextMessage(String message, ButtonData? buttonData) {
    final addtionalData = {'value': message};
    _emitChatEvent('text',
        additionalData: addtionalData, buttonData: buttonData);
  }

  void sendUrlMessage(String url, ButtonData? buttonData) {
    final additionalData = {'value': url};
    _emitChatEvent('url_click',
        additionalData: additionalData, buttonData: buttonData);
  }

  void sendRatingMessage(int rating, ButtonData? buttonData) {
    final additionalData = {
      'value': {'rating': rating}
    };
    _emitChatEvent('rating',
        additionalData: additionalData, buttonData: buttonData);
  }

  void sendScenarioMessage(String scenario, ButtonData? buttonData) {
    _emitChatEvent('scenario',
        additionalData: {
          'value': {'scenario': scenario}
        },
        buttonData: buttonData);
  }

  void sendVariableMessage(String name, String value, ButtonData? buttonData) {
    final additionalData = {
      'value': {"name": name, "value": value}
    };
    _emitChatEvent('variable',
        additionalData: additionalData, buttonData: buttonData);
  }

  void sendUpdateConversationInfoMessage(
      Map<String, dynamic> conversationInfo, ButtonData? buttonData) {
    final additionalData = {"value": conversationInfo, "stop": true};
    _emitChatEvent('update_conversation_info',
        buttonData: buttonData, additionalData: additionalData);
  }

  void sendButtonClickedMessage(ButtonData buttonData) {
    _logger?.d(
        "Button click detected, sending button click event for button id: ${buttonData.buttonId}, label: ${buttonData.label}");
    dynamic buttonClickData = _getButtonClickData(buttonData);
    _chatListener.emitEvent("request.chat", buttonClickData);
  }

  void sendCloseChatMessage() {
    final additionalData = {"value": 'action_close_chat', "stop": true};
    _emitChatEvent('action', additionalData: additionalData);
  }

  void sendBotMessageFromAnswer(Answers answer) {
    var message = Message(
      type: answer.type,
      data: MessageData(
        message: MessageContent(
          id: const Uuid().v4(),
          botId: _botId,
          chatId: _chatId,
          companyId: _botId,
          sender: "configuration",
          value: answer.value,
          timestamp: DateTime.now().fractionalSecond(),
          input_field: answer.input_field,
          type: answer.type,
        ),
      ),
      requestId: const Uuid().v4(),
    );

    _addToMessageStreamController(message);
  }

  void sendImageMessage(ImageResponse imageResponse) {
    _logger?.d(
        "Sending image message for filename: ${imageResponse.filename}, mimetype: ${imageResponse.mimeType}, uploaded filepath: ${imageResponse.image.filepath}, size: ${imageResponse.size}");
    final imageData = _getImageData(imageResponse);
    _chatListener.emitEvent("request.chat", imageData);
  }

  void _emitChatEvent(String type,
      {ButtonData? buttonData, dynamic additionalData}) {
    // If no events have been emitted before, send a web_init chat as well
    if (!_firstEventSent) {
      dynamic webInitData = _getWebInitEventData();
      _logger?.d("Emitting web_init event");
      _logger?.d(webInitData);
      _chatListener.emitEvent("request.chat", webInitData);
      _firstEventSent = true;
    }

    // If a button id has been passed, we need to emit a button clicked event before
    // we send the actual event
    if (buttonData != null) {
      _logger?.d(
          "Button click detected, sending button click event for button id: ${buttonData.buttonId}, label: ${buttonData.label}");
      dynamic buttonClickData = _getButtonClickData(buttonData);
      _logger?.d(buttonClickData);
      _chatListener.emitEvent("request.chat", buttonClickData);
    }

    dynamic publishData = _getPublishData(type, additionalData: additionalData);

    _logger?.d("Emitting event");
    _logger?.d(publishData);

    _chatListener.emitEvent("request.chat", publishData);
  }

  dynamic _getPublishData(String type,
      {Map<String, dynamic>? conversationData,
      Map<String, dynamic>? additionalData}) {
    var id = const Uuid().v4();
    return {
      "clientId": _botId,
      "conversation": conversationData ?? {},
      "data": {
        "id": id,
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "sender": "user",
        "timestamp": DateTime.now().fractionalSecond(),
        "type": type,
        "username": _chatId,
        ...?additionalData
      },
      "id": id,
      "event": "request.chat"
    };
  }

  dynamic _getButtonClickData(ButtonData buttonData) {
    var id = const Uuid().v4();
    return {
      "clientId": _botId,
      "conversation": {"user_last_input": buttonData.buttonId},
      "data": {
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "sender": "user",
        "timestamp": DateTime.now().fractionalSecond(),
        "type": "button_click",
        "username": _chatId,
        "buttonId": buttonData.buttonId,
        "label": buttonData.label,
        "value": buttonData.label
      },
      "id": id,
      "event": "request.chat"
    };
  }

  dynamic _getWebInitEventData() {
    var id = const Uuid().v4();

    return {
      "clientId": _botId,
      "conversation": {},
      "data": {
        "id": id,
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "sender": "user",
        "timestamp": DateTime.now().fractionalSecond(),
        "type": "web_init",
        "username": _chatId,
      },
      "id": id,
      "event": "request.chat"
    };
  }

  dynamic _getImageData(ImageResponse imageResponse) {
    var id = const Uuid().v4();
    return {
      "clientId": _botId,
      "conversation": {},
      "data": {
        "id": id,
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "sender": "user",
        "timestamp": DateTime.now().fractionalSecond(),
        "type": "image",
        "username": _chatId,
        "value": {
          "filename": imageResponse.filename,
          "key": imageResponse.image.filepath,
          "label": imageResponse.filename,
          "mimetype": imageResponse.mimeType,
          "size": imageResponse.size
        }
      },
      "id": id,
      "event": "request.chat"
    };
  }

  void _addToMessageStreamController(Message message) {
    if (_messageStreamController.isClosed) {
      _logger?.w("Message stream is closed, not adding message");
      return;
    }

    _messageStreamController.add(message);
  }
}