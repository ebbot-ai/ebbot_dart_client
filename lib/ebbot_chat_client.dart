library ebbot_chat;

import 'dart:async';

import 'package:ebbot_dart_client/ebbot_chat_listener.dart';
import 'package:ebbot_dart_client/entities/chat.dart';
import 'package:ebbot_dart_client/entities/chat_config.dart';
import 'package:ebbot_dart_client/entities/message.dart';
import 'package:ebbot_dart_client/entities/session_init.dart';
import 'package:ebbot_dart_client/network/asyngular_client.dart';
import 'package:ebbot_dart_client/network/ebbot_http_client.dart';
import 'package:ebbot_dart_client/valueobjects/message_type.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class EbbotDartClient {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  //late Socket socket;

  final String botId;
  final String chatId = "${DateTime.now().millisecondsSinceEpoch}-${Uuid().v4()}";

  final _chatStreamController = StreamController<Chat>.broadcast();
  final _messageStreamController = StreamController<Message>.broadcast();

  Stream<Message> get messageStream => _messageStreamController.stream;
  Stream<Chat> get chatStream => _chatStreamController.stream;

  late EbbotChatListener _listener;
  late EbbotHttpClient _ebbotHttpClient;

  late ChatConfig _chatConfig;
  late SessionInit _chatInitConfig;
  late AsyngularClient _asyngularClient;

  EbbotChatListener get listener => _listener;


  EbbotDartClient(this.botId);

  Future<void> initialize() async {
    logger.i("initialize");
    
    _ebbotHttpClient = EbbotHttpClient(botId, chatId);
    _chatInitConfig = await _ebbotHttpClient.initSession();
    _chatConfig = await _ebbotHttpClient.fetchConfig();

    logger.i("initialization result:$_chatInitConfig");
    logger.i("Config result:$_chatConfig");

    final data = _chatInitConfig.data;
    final session = data.session;

    _listener = EbbotChatListener(
        _chatInitConfig, _messageStreamController, _chatStreamController);

    _asyngularClient = AsyngularClient(session.botId, session.chatId, data.token, _listener);
    await _asyngularClient.initalize();

    await _onSubscribed(); // Wait until we have subscribed
  }
  
  void startReceive() {
    // Dispatch any scenarios as a message from the chatbot
    var answers = _chatConfig.scenario.answers;
    
    for (var answer in answers) {
      if (answer.type != "text") {
        logger.i("skipping answer of type: ${answer.type}");
        continue;
      }

      // This is somewhat a hack to emulate that the bot is in fact sending a message
      logger.i("dispatching answer: ${answer.value}");
      var message = Message(
        type: "gpt",
        data: MessageData(
          message: MessageContent(
            id: Uuid().v4(),
            botId: botId,
            chatId: chatId,
            companyId: botId,
            sender: "bot",
            value: answer.value,
            timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
            type: MessageType.gpt,
          ),
        ),
        requestId: Uuid().v4(),
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

  void dispose() {
    logger.i("Disposing of chat client socket");

    /*if (socket != null) {
      logger.i("Socket has been initialized, closing it");
      socket.unsubscribe("request.chat");
      socket.closeWebsocket();
    }*/
    logger.i("Disposing of chat client streams");
    _chatStreamController.close();
    _messageStreamController.close();
  }

  void sendMessage(String message) {
    var id = Uuid().v4();
    var publishdata = {
      "clientId": botId,
      "conversation": {"user_last_input": message},
      "data": {
        "id": id,
        "full_name": "Test Testsson",
        "chatId": chatId,
        "finished": true,
        "pending": false,
        "sender": "user",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "type": "text",
        "username": chatId,
        "value": message,
      },
      "id": id,
      "event": "request.chat"
    };
    _listener.subscribe?.emit("request.chat", publishdata);
    //socket.emit("request.chat", publishdata);
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
