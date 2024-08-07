import 'dart:async';

import 'package:ebbot_dart_client/entity/chat/chat.dart';
import 'package:ebbot_dart_client/entity/message/message.dart';
import 'package:ebbot_dart_client/entity/notification/notification.dart';
import 'package:ebbot_dart_client/entity/session/session_init.dart';
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
    if (_chatStreamController.isClosed) {
      logger.w("Chat stream controller is closed");
      return;
    }
    if (_chatStreamController.isPaused) {
      logger.w("Chat stream controller is paused");
      return;
    }

    _chatStreamController.add(chat);
  }

  void _onMessageCreated(Message message) {
    if (_messageStreamController.isClosed) {
      logger.w("Message stream controller is closed");
      return;
    }
    if (_messageStreamController.isPaused) {
      logger.w("Message stream controller is paused");
      return;
    }

    _messageStreamController.add(message);
  }

  Future<void> closeStreamControllers() async {
    await _messageStreamController.close();
    await _chatStreamController.close();
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
      logger.i(
          "subscribe.onSubscribe: subscription ID: $subscriptionId name: $name data length: ${data.length}");

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
