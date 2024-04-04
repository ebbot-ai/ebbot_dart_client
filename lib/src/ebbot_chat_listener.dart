import 'dart:async';

import 'package:ebbot_dart_client/entities/chat/chat.dart';
import 'package:ebbot_dart_client/entities/message/message.dart';
import 'package:ebbot_dart_client/entities/session/session_init.dart';
import 'package:socketcluster_client/socketcluster_client.dart';
import 'package:logger/logger.dart';

class EbbotChatListener extends BasicListener {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  final HttpSession _initResult;
  final StreamController<Message> _messageStreamController;
  final StreamController<Chat> _chatStreamController;

  // used from the implementation side to publish chat messags
  late Socket? subscribe;

  // used from the implementation side to subscribe to messages and chats
  Stream<Message> get messageStream => _messageStreamController.stream;
  Stream<Chat> get chatStream => _chatStreamController.stream;

  EbbotChatListener(this._initResult, this._messageStreamController,
      this._chatStreamController);

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

    final chatId = _initResult.data.session.chatId;

    // Subscribe to the chat
    var subscriptionId = 'response.chat.$chatId';
    subscribe = socket.subscribe(subscriptionId);

    subscribe?.onSubscribe(subscriptionId, (name, data) {
      logger.i("subscribe.onSubscribe:: subscription ID: $name");

      // Deserialize the data to either Chat or Message depending on $data['type']
      // data is an array of messages or chats
      for (var item in data) {
        final type = item['type'];
        switch (type) {
          case 'message':
            logger.i("Handling type: $type");
            var message = Message.fromJson(item);
            _onMessageCreated(message);
            break;
          case 'chat':
            logger.i("Handling type: $type");
            var chat = Chat.fromJson(item);
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
    logger.i("Subscribed!!");
  }

  @override
  void onDisconnected(Socket socket) {
    logger.i("onDisconnected: socket $socket");
  }

  @override
  void onSetAuthToken(String? token, Socket socket) {
    logger.i('onSetAuthToken: socket $socket token $token');
    socket.authToken = token;
  }
}
