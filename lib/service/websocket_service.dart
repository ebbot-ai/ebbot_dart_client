import 'dart:async';

import 'package:ebbot_dart_client/configuration/configuration.dart';
import 'package:ebbot_dart_client/entity/chat/chat.dart';
import 'package:ebbot_dart_client/entity/chat_config/chat_config.dart';
import 'package:ebbot_dart_client/entity/message/message.dart';
import 'package:ebbot_dart_client/service/log_service.dart';
import 'package:ebbot_dart_client/src/ebbot_chat_listener.dart';
import 'package:ebbot_dart_client/src/network/asyngular_websocket_client.dart';
import 'package:ebbot_dart_client/util/time.dart';
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

  final _messageStreamController = StreamController<Message>.broadcast();
  final _chatStreamController = StreamController<Chat>.broadcast();

  bool _firstEventSent = true;

  Stream<Message> get messageStream => _messageStreamController.stream;
  Stream<Chat> get chatStream => _chatStreamController.stream;

  WebSocketService(this._botId, this._chatId, this._configuration) {
    _logger = GetIt.I<LogService>().logger;
    _asyngularWebsocketClient = _createAsyngularWebsocketClient();
    _chatListener = _createListener();
  }

  Future<void> connect(String token) async {
    _socket = await _asyngularWebsocketClient.initSocket(token, _chatListener);
    await _onSubscribed();
  }

  EbbotChatListener _createListener() {
    return EbbotChatListener(
      _chatId,
      _messageStreamController,
      _chatStreamController,
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

    _logger?.i("Closing chat client streams");
    await _chatListener.closeStreamControllers();
  }

  void sendTextMessage(String message, String? buttonId) {
    _emitChatEvent('text', message, buttonId);
  }

  void sendUrlMessage(String url, String? buttonId) {
    _emitChatEvent('url_click', url, buttonId);
  }

  void sendRatingMessage(int rating, String? buttonId) {
    _emitChatEvent('rating', additionalData: {'rating': rating}, buttonId);
  }

  void sendScenarioMessage(String scenario, String? buttonId) {
    _emitChatEvent(
        'scenario', additionalData: {'scenario': scenario}, buttonId);
  }

  void sendVariableMessage(String name, String value, String? buttonId) {
    _emitChatEvent('variable', value, buttonId,
        additionalData: {'name': name, 'value': value});
  }

  void sendUpdateConversationInfoMessage(
      Map<String, dynamic> conversationInfo, String? buttonId) {
    _emitChatEvent('update_conversation_info', conversationInfo, buttonId,
        additionalData: {'stop': true});
  }

  /*void sendButtonClickedMessage(String buttonId, String value) {
    _emitChatEvent('button_click', value,
        additionalData: {'buttonId': buttonId});
  }*/

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

  void _emitChatEvent(String type,
      {String? buttonId, Map<String, dynamic>? additionalData}) {
    if (_chatListener.subscribe == null) {
      _logger?.w("Not subscribed, not emitting event");
      return;
    }

    // If no events have been emitted before, send a web_init chat as well
    if (_firstEventSent) {
      dynamic webInitData = _getWebInitEventData();
      _logger?.i("Emitting web_init event");
      _chatListener.subscribe?.emit("request.chat", webInitData);
      _firstEventSent = false;
    }

    // If a button id has been passed, we need to emit a button clicked event before
    // we send the actual event
    if (buttonId != null) {
      _logger?.i("Button click detected, sending button click event");
      dynamic buttonData = _getButtonClickData(buttonId);
      _chatListener.subscribe?.emit("request.chat", buttonData);
    }

    dynamic publishData = _getPublishData(type, additionalData: additionalData);

    _chatListener.subscribe?.emit("request.chat", publishData);
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

  dynamic _getButtonClickData(String buttonId) {
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
        "type": "button_click",
        "username": _chatId,
        "buttonId": buttonId,
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

  void _addToMessageStreamController(Message message) {
    if (_messageStreamController.isClosed) {
      _logger?.w("Message stream is closed, not adding message");
      return;
    }

    _messageStreamController.add(message);
  }

  Future<void> _onSubscribed() async {
    Completer<void> completer = Completer<void>();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _logger?.i("Checking if we have subscribed");
      if (_chatListener.subscribe != null) {
        _logger?.i("We have subscribed");
        timer.cancel();
        completer.complete();
      }
    });

    return completer.future;
  }
}
