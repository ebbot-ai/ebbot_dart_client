import 'dart:async';

import 'package:ebbot_chat/entities/chat.dart';
import 'package:ebbot_chat/entities/message.dart';
import 'package:socketcluster_client/socketcluster_client.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';

class EbbotChatListener extends BasicListener {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  dynamic result;

  StreamController<Message> _messageStreamController;
  StreamController<Chat> _chatStreamController;

  late Socket? subscribe;

  Stream<Message> get messageStream => _messageStreamController.stream;
  Stream<Chat> get chatStream => _chatStreamController.stream;

  EbbotChatListener(
      this.result, this._messageStreamController, this._chatStreamController);

  void _onChatCreated(Chat chat) {
    _chatStreamController.add(chat);
  }

  void _onMessageCreated(Message message) {
    _messageStreamController.add(message);
  }

  @override
  void onAuthentication(Socket socket, bool? status) {}

  @override
  void onConnectError(Socket socket, e) {
    logger.w(
        "onConnectError: socket $socket e $e"); // What do we do here? Reconnect?
  }

  @override
  void onConnected(Socket socket) async {
    logger.i("onConnected: socket $socket");

    var chatId = result['data']['session']['chatId'];
    var botId = result['data']['session']['botId'];
    var session = result['data']['session']['session'];
    var token = result['data']['token'];

    // Let's try to chat!
    // first, we subscribe to a channel
    // the channel is response.chat. followed by the chatId
    var subscriptionId = 'response.chat.${chatId}';
    subscribe = socket.subscribe(subscriptionId);

    subscribe?.onSubscribe(subscriptionId, (name, data) {
      logger.i("subscribe.onSubscribe:: subscription ID: $name data: $data");

      // Deserialize the data to either Chat or Message depending on $data['type']
      // data is an array of messages or chats
      for (var item in data) {
        final type = item['type'];
        switch (type) {
          case 'message':
            logger.i("Handling type: $type");
            var message = Message.fromJson(item);
            print(message);
            _onMessageCreated(message);
            break;
          case 'chat':
            logger.i("Handling type: $type");
            var chat = Chat.fromJson(item);
            print(chat);
            _onChatCreated(chat);
            break;
          default:
            // Handle unknown type
            logger.i("Unsupported type: $type");
            break;
        }
      }
    });

    // Subscribed!
    logger.i("Subscribed!!!");

    /*var id = Uuid().v4();
    var message = "What is a chainsaw?";
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

    subscribe?.emit("request.chat", publishdata);*/

    // extract this to a function

    /*new Timer.periodic(const Duration(seconds: 2), (_) {
      print('Attempting to send');
      socket.emit('sampleClientEvent',
          {'message': 'This is an object with a message property'});
    });*/
  }

  @override
  void onDisconnected(Socket socket) {
    logger.w("onDisconnected: socket $socket");
  }

  @override
  void onSetAuthToken(String? token, Socket socket) {
    logger.w('onSetAuthToken: socket $socket token $token');
    socket.authToken = token;
  }
}
