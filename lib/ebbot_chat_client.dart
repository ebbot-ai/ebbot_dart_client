library ebbot_chat;

import 'dart:async';

import 'package:ebbot_chat/ebbot_chat_listener.dart';
import 'package:ebbot_chat/entities/chat.dart';
import 'package:ebbot_chat/entities/message.dart';
import 'package:ebbot_chat/network/ebbot_http_client.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:socketcluster_client/socketcluster_client.dart';

const botId = "ebqqtpv3h1qzwflhfroyzc7jzdxqqx";

class EbbotChatClient {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  late Socket socket;

  final String botId;
  final String chatId;

  final _chatStreamController = StreamController<Chat>.broadcast();
  final _messageStreamController = StreamController<Message>.broadcast();

  Stream<Message> get messageStream => _messageStreamController.stream;
  Stream<Chat> get chatStream => _chatStreamController.stream;

  late EbbotChatListener listener;

  EbbotChatClient(this.botId, {String? chatId})
      : chatId =
            chatId ?? "${DateTime.now().millisecondsSinceEpoch}-${Uuid().v4()}";

  Future<void> initialize() async {
    logger.i("initialize");
    var httpClient = EbbotHttpClient(this.botId, this.chatId);
    var result = await httpClient.initEbbot();

    logger.i("initialization result:$result");

    var chatId = result['data']['session']['chatId'];
    var botId = result['data']['session']['botId'];
    var session = result['data']['session']['session']; // What is it used for?
    var token = result['data']['token'];

    listener = EbbotChatListener(
        result, _messageStreamController, _chatStreamController);

    socket = await Socket.connect(
        'wss://v2.ebbot.app/api/asyngular/?botId=$botId&chatId=$chatId&token=$token',
        listener: listener);

    await _onSubscribed(); // Wait until we have subscribed
  }

  void dispose() {
    // TODO :We should probably close the socket here
    // We need to implement support for it in the Socket lib
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
