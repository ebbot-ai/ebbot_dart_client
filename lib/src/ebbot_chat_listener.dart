import 'dart:async';

import 'package:ebbot_dart_client/entity/chat/chat.dart';
import 'package:ebbot_dart_client/entity/message/message.dart';
import 'package:ebbot_dart_client/service/log_service.dart';
import 'package:get_it/get_it.dart';
import 'package:socketcluster_client/socketcluster_client.dart';

class EbbotChatListener extends BasicListener {
  final _logger = GetIt.instance<LogService>().logger;

  final String _chatId;
  //final StreamController<Message> messageStreamController;
  //final StreamController<Chat> chatStreamController;

  // used from the implementation side to publish chat messags
  late Socket? _subscribe;

  // used from the implementation side to subscribe to messages and chats
  Stream<Message> get messageStream => messageStreamController.stream;
  Stream<Chat> get chatStream => chatStreamController.stream;

  StreamController<Message> messageStreamController =
      StreamController<Message>.broadcast();
  StreamController<Chat> chatStreamController =
      StreamController<Chat>.broadcast();

  EbbotChatListener(this._chatId);

  Future<void> onSubscribed() async {
    Completer<void> completer = Completer<void>();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _logger?.i("Checking if we have subscribed");
      if (_subscribe != null) {
        _logger?.i("We have subscribed");
        timer.cancel();
        completer.complete();
      }
    });

    return completer.future;
  }

  void emitEvent(String event, dynamic data) {
    if (_subscribe == null) {
      _logger?.w("Not subscribed, not emitting event");
    }

    _subscribe?.emit(event, data);
  }

  void _onChatCreated(Chat chat) {
    if (chatStreamController.isClosed) {
      _logger?.w("Chat stream controller is closed");
      return;
    }
    if (chatStreamController.isPaused) {
      _logger?.w("Chat stream controller is paused");
      return;
    }

    chatStreamController.add(chat);
  }

  void _onMessageCreated(Message message) {
    if (messageStreamController.isClosed) {
      _logger?.w("Message stream controller is closed");
      return;
    }
    if (messageStreamController.isPaused) {
      _logger?.w("Message stream controller is paused");
      return;
    }

    messageStreamController.add(message);
  }

  Future<void> reinitStreamControllers() async {
    await messageStreamController.close();
    await chatStreamController.close();
    messageStreamController = StreamController<Message>.broadcast();
    chatStreamController = StreamController<Chat>.broadcast();
  }

  @override
  void onAuthentication(Socket socket, bool? status) {}

  @override
  void onConnectError(Socket socket, e) {
    _logger?.w(
        "onConnectError: socket $socket e $e"); // What do we do here? Reconnect?
  }

  @override
  void onConnected(Socket socket) async {
    _logger?.i("onConnected: socket $socket");

    // Subscribe to the chat
    var subscriptionId = 'response.chat.$_chatId';
    _subscribe = socket.subscribe(subscriptionId);

    _subscribe?.onSubscribe(subscriptionId, (name, data) {
      _logger?.i(
          "subscribe.onSubscribe: subscription ID: $subscriptionId name: $name data length: ${data.length}");

      // Deserialize the data to either Chat or Message depending on $data['type']
      // data is an array of messages or chats
      for (var item in data) {
        final type = item['type'];
        switch (type) {
          case 'message':
            _logger?.i("Handling type: $type");
            var message = Message.fromJson(item);
            _onMessageCreated(message);
            break;
          case 'chat':
            _logger?.i("Handling type: $type");
            var chat = Chat.fromJson(item);
            _onChatCreated(chat);
            break;
          default:
            // Handle unknown type
            _logger?.w("Unsupported type: $type");
            break;
        }
      }
    });
  }

  @override
  void onDisconnected(Socket socket) {
    _logger?.i("onDisconnected: socket $socket");
  }

  @override
  void onSetAuthToken(String? token, Socket socket) {
    _logger?.i('onSetAuthToken: socket $socket token $token');
    socket.authToken = token;
  }
}
