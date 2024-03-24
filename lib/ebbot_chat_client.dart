library ebbot_chat;

import 'dart:async';

import 'package:ebbot_dart_client/ebbot_chat_listener.dart';
import 'package:ebbot_dart_client/entities/chat.dart';
import 'package:ebbot_dart_client/entities/chat_config.dart';
import 'package:ebbot_dart_client/entities/message.dart';
import 'package:ebbot_dart_client/entities/session_init.dart';
import 'package:ebbot_dart_client/network/ebbot_http_client.dart';
import 'package:ebbot_dart_client/valueobjects/message_type.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:socketcluster_client/socketcluster_client.dart';

class EbbotDartClient {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  late Socket socket;

  final String botId;
  final String chatId = "${DateTime.now().millisecondsSinceEpoch}-${Uuid().v4()}";

  final _chatStreamController = StreamController<Chat>.broadcast();
  final _messageStreamController = StreamController<Message>.broadcast();

  Stream<Message> get messageStream => _messageStreamController.stream;
  Stream<Chat> get chatStream => _chatStreamController.stream;

  late EbbotChatListener listener;
  late EbbotHttpClient _ebbotHttpClient;

  late ChatConfig _chatConfig;
  late SessionInit _chatInitConfig;

  EbbotDartClient(this.botId);

  Future<void> initialize() async {
    logger.i("initialize");
    
    _ebbotHttpClient = EbbotHttpClient(botId, chatId);
    _chatInitConfig = await _ebbotHttpClient.initEbbot();
    _chatConfig = await _ebbotHttpClient.fetchConfig();

    logger.i("initialization result:$_chatInitConfig");
    logger.i("Config result:$_chatConfig");

    final data = _chatInitConfig.data;
    final session = data.session;

    listener = EbbotChatListener(
        _chatInitConfig, _messageStreamController, _chatStreamController);

    socket = await Socket.connect(
        'wss://v2.ebbot.app/api/asyngular/?botId=${session.botId}&chatId=${session.chatId}&token=${data.token}',
        listener: listener);

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
    // TODO :We should probably close the socket here
    // We need to implement support for it in the Socket lib
    logger.i("Disposing of chat client socket");

    if (socket != null) {
      logger.i("Socket has been initialized, closing it");
      socket.unsubscribe("request.chat");
      socket.closeWebsocket();
    }
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
    listener.subscribe?.emit("request.chat", publishdata);
    //socket.emit("request.chat", publishdata);
  }

  Future<void> _onSubscribed() async {
    Completer<void> completer = Completer<void>();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      logger.i("Checking if we have subscribed");
      if (listener.subscribe != null) {
        logger.i("We have subscribed");
        timer.cancel();
        completer.complete();
      }
    });

    return completer.future;
  }
}
