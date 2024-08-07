library ebbot_chat;

import 'dart:async';

import 'package:ebbot_dart_client/configuration/configuration.dart';
import 'package:ebbot_dart_client/entity/notification/notification.dart';
import 'package:ebbot_dart_client/src/ebbot_chat_listener.dart';
import 'package:ebbot_dart_client/entity/chat/chat.dart';
import 'package:ebbot_dart_client/entity/chat_config/chat_config.dart';
import 'package:ebbot_dart_client/entity/message/message.dart';
import 'package:ebbot_dart_client/entity/session/session_init.dart';
import 'package:ebbot_dart_client/src/network/asyngular_http_client.dart';
import 'package:ebbot_dart_client/src/network/asyngular_websocket_client.dart';
import 'package:ebbot_dart_client/src/network/ebbot_http_client.dart';
import 'package:logger/logger.dart';
import 'package:socketcluster_client/socketcluster_client.dart';
import 'package:uuid/uuid.dart';

class EbbotDartClient {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  final String _botId;
  final Configuration _configuration;
  final String _chatId =
      "${DateTime.now().millisecondsSinceEpoch}-${const Uuid().v4()}";
  String get chatId => _chatId;

  final _chatStreamController = StreamController<Chat>.broadcast();
  Stream<Message> get messageStream => _messageStreamController.stream;
  final _messageStreamController = StreamController<Message>.broadcast();
  Stream<Chat> get chatStream => _chatStreamController.stream;

  late EbbotHttpClient _ebbotHttpClient;
  late HttpSession _httpSession;
  // ignore: unused_field
  late Socket _socket;
  late ChatConfig _chatConfig;
  late AsyngularHttpClient _asyngularHttpClient;
  late AsyngularWebsocketClient _asyngularWebsocketClient;

  late EbbotChatListener _listener;
  EbbotChatListener get listener => _listener;

  final List<Notification> _notifications = [];
  List<Notification> get notifications => _notifications;

  EbbotDartClient(this._botId, this._configuration);

  Future<void> initialize() async {
    logger.i("initialize");

    logger.i("Fetching configuration from server");
    // Initialize the http client
    _ebbotHttpClient = EbbotHttpClient(
        botId: _botId, chatId: _chatId, env: _configuration.environment);

    _chatConfig = await _ebbotHttpClient.fetchConfig();
    logger.i("Successfully fetched configuration from server");

    // Add any notifications to the list
    // TODO: reactor this to separate class when i have the time
    if (_chatConfig.chat_style.v2.info_section_enabled &&
        _chatConfig.chat_style.v2.info_section_in_conversation) {
      var title = _chatConfig.chat_style.v2.info_section_title;
      var text = _chatConfig.chat_style.v2.info_section_text;
      _notifications.add(Notification(title, text, true));
    }

    // Initalize the asyngular client
    logger.i("Initializing asyngular client and initializing session");
    _asyngularHttpClient =
        AsyngularHttpClient(_botId, _chatId, _configuration.environment);

    _httpSession = await _asyngularHttpClient.initSession();
    logger.i("Successfully initialized asyngular client and session");

    _listener = EbbotChatListener(
        _httpSession, _messageStreamController, _chatStreamController);

    logger.i("Initializing asyngular websocket client");
    _asyngularWebsocketClient =
        AsyngularWebsocketClient(_botId, _chatId, _configuration.environment);
    logger.i("Successfully initialized asyngular websocket client");

    logger.i("Initializing socket");
    _socket =
        await _asyngularWebsocketClient.initSocket(_httpSession, _listener);
    logger.i("Successfully initialized socket");

    logger.i("Subscribing to chat");
    await _onSubscribed(); // Wait until we have subscribed
    logger.i("Successfully subscribed to chat");
  }

  void startReceive() {
    // Dispatch any scenarios as a message from the chatbot
    var answers = _chatConfig.scenario.answers;

    for (var answer in answers) {
      /*if (answer.type != "text") {
        logger.i("skipping answer of type: ${answer.type}");
        continue;
      }*/

      // This is somewhat a hack to emulate that the bot is in fact sending a message
      logger.i("dispatching answer: ${answer.value}");
      var message = Message(
        type: answer.type, //"answer",
        data: MessageData(
          message: MessageContent(
            id: const Uuid().v4(),
            botId: _botId,
            chatId: _chatId,
            companyId: _botId,
            sender: "bot",
            value: answer.value,
            timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
            input_field: answer.input_field,
            type: answer.type,
          ),
        ),
        requestId: const Uuid().v4(),
      );

      // check if stream is closed before adding message
      // else log a warning
      if (!_messageStreamController.isClosed) {
        _messageStreamController.add(message);
      } else {
        logger.w("Message stream is closed, not adding message");
      }
    }
  }

  Future<void> closeAsync({bool closeSocket = false}) async {
    logger.i("Closing chat client socket");

    sendCloseChat();
    await _asyngularHttpClient.endSession();

    if (closeSocket == true) {
      logger.i("Socket has been initialized, closing it");
      _socket.unsubscribe("request.chat");
      _socket.closeWebsocket();
    }

    logger.i("Closing chat client streams");
    await _listener.closeStreamControllers();
  }

  void sendTextMessage(String message) {
    var id = const Uuid().v4();
    var publishdata = {
      "clientId": _botId,
      "conversation": {"user_last_input": message},
      "data": {
        "id": id,
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "pending": true,
        "sender": "user",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "type": "text",
        "username": _chatId,
        "value": message,
      },
      "id": id,
      "event": "request.chat"
    };
    logger.i("Sending text message with message: $message");
    if (_listener.subscribe == null) {
      logger.w("No subscription available, not sending message");
      return;
    }
    _listener.subscribe?.emit("request.chat", publishdata);
  }

  void sendUrlMessage(String url) {
    var id = const Uuid().v4();
    var publishdata = {
      "clientId": _botId,
      "conversation": {"user_last_input": url},
      "data": {
        "id": id,
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "sender": "user",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "type": "url_click",
        "username": _chatId,
        "value": url,
      },
      "id": id,
      "event": "request.chat"
    };
    logger.i("Sending url message with url: $url");
    if (_listener.subscribe == null) {
      logger.w("No subscription available, not sending message");
      return;
    }
    _listener.subscribe?.emit("request.chat", publishdata);
  }

  void sendRatingMessage(int rating) {
    var id = const Uuid().v4();
    var ratingValue = {
      "rating": rating,
    };

    var publishdata = {
      "clientId": _botId,
      "conversation": {"rating": rating, "user_last_input": ratingValue},
      "data": {
        "id": id,
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "sender": "user",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "type": "rating",
        "username": _chatId,
        "value": ratingValue,
      },
      "id": id,
      "event": "request.chat"
    };
    logger.i("Sending rating message with rating: $rating");
    if (_listener.subscribe == null) {
      logger.w("No subscription available, not sending message");
      return;
    }
    _listener.subscribe?.emit("request.chat", publishdata);
  }

  void sendScenarioMessage(String scenario) {
    var id = const Uuid().v4();
    var publishdata = {
      "clientId": _botId,
      "conversation": {"user_last_input": scenario},
      "data": {
        "id": id,
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "sender": "user",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "type": "scenario",
        "username": _chatId,
        "value": {"scenario": scenario},
      },
      "id": id,
      "event": "request.chat"
    };
    logger.i("Sending scenario message with scenario: $scenario");
    if (_listener.subscribe == null) {
      logger.w("No subscription available, not sending message");
      return;
    }
    _listener.subscribe?.emit("request.chat", publishdata);
  }

  void sendVariableMessage(String name, String value) {
    var id = const Uuid().v4();
    var publishdata = {
      "clientId": _botId,
      "conversation": {
        "user_last_input": {"name": name, "value": value}
      },
      "data": {
        "id": id,
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "sender": "user",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "type": "variable",
        "username": _chatId,
        "value": {"name": name, "value": value},
      },
      "id": id,
      "event": "request.chat"
    };
    logger.i("Sending variable message with name: $name and value: $value");
    if (_listener.subscribe == null) {
      logger.w("No subscription available, not sending message");
      return;
    }
    _listener.subscribe?.emit("request.chat", publishdata);
  }

  void sendUpdateConversationInfo(Map<String, dynamic> conversationInfo) {
    var id = const Uuid().v4();
    var publishdata = {
      "clientId": _botId,
      "conversation": {
        "user_last_input": conversationInfo,
      },
      "data": {
        "id": id,
        "full_name": "Test Testsson", // TODO: Use real name
        "chatId": _chatId,
        "finished": true,
        "stop": true,
        "sender": "user",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "type": "update_conversation_info",
        "username": _chatId,
        "value": conversationInfo,
      },
      "id": id,
      "event": "request.chat"
    };
    logger.i("Sending conversation info update with info: $conversationInfo");
    if (_listener.subscribe == null) {
      logger.w("No subscription available, not sending message");
      return;
    }
    _listener.subscribe?.emit("request.chat", publishdata);
  }

  void sendCloseChat() {
    var id = const Uuid().v4();
    var publishdata = {
      "clientId": _botId,
      "conversation": {"user_last_input": "action_close_chat"},
      "data": {
        "id": id,
        "chatId": _chatId,
        "full_name": "Test Testsson", // TODO: Use real name
        "finished": true,
        "chatId": _chatId,
        "finished": true,
        "stop": true,
        "sender": "user",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "type": "action",
        "username": _chatId,
        "value": "action_close_chat",
      },
      "id": id,
      "event": "request.chat"
    };
    logger.i("Sending close chat message");
    if (_listener.subscribe == null) {
      logger.w("No subscription available, not sending message");
      return;
    }
    _listener.subscribe?.emit("request.chat", publishdata);
  }

  Future<void> _onSubscribed() async {
    Completer<void> completer = Completer<void>();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      logger.i("Checking if we have subscribed");
      if (_listener.subscribe != null) {
        logger.i("We have subscribed");
        timer.cancel();
        completer.complete();
      }
    });

    return completer.future;
  }
}
