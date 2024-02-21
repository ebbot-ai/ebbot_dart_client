library ebbot_chat;

import 'dart:async';

import 'package:ebbot_chat/entities/chat.dart';
import 'package:ebbot_chat/entities/message.dart';
import 'package:ebbot_chat/network/ebbot_http_client.dart';
import 'package:uuid/uuid.dart';
import 'package:socketcluster_client/socketcluster_client.dart';

const botId = "ebqqtpv3h1qzwflhfroyzc7jzdxqqx";

class EbbotChatListener extends BasicListener {
  dynamic result;

  StreamController<Message> _messageStreamController;
  StreamController<Chat> _chatStreamController;

  bool hasSubscribed = false;

  Stream<Message> get messageStream => _messageStreamController.stream;
  Stream<Chat> get chatStream => _chatStreamController.stream;

  EbbotChatListener(this.result, this._messageStreamController, this._chatStreamController);

  void _onChatCreated(Chat chat) {
    _chatStreamController.add(chat);
  }

  void _onMessageCreated(Message message) {
    _messageStreamController.add(message);
  }

  @override
  void onAuthentication(Socket socket, bool? status) {
    print(
        '[EbbotChatListener.onAuthentication] ------> socket $socket status $status');
  }

  @override
  void onConnectError(Socket socket, e) {
    print('[EbbotChatListener.onConnectError] ------> socket $socket e $e');
  }

  @override
  void onConnected(Socket socket) async {
    print('[EbbotChatListener.onConnected] ------> socket $socket');

    var chatId = result['data']['session']['chatId'];
    var botId = result['data']['session']['botId'];
    var session = result['data']['session']['session'];
    var token = result['data']['token'];

    // Let's try to chat!
    // first, we subscribe to a channel
    // the channel is response.chat. followed by the chatId
    var subscriptionId = 'response.chat.${chatId}';
    var subscribe = socket.subscribe(subscriptionId);

    hasSubscribed = true;

    subscribe.onSubscribe(subscriptionId, (name, data) {
      print("subscribe.onSubscribe ------> subscription ID: $name data: $data");

      // Deserialize the data to either Chat or Message depending on $data['type']
      // data is an array of messages or chats
      for (var item in data) {
        final type = item['type'];
        switch (type) {
          case 'message':
            print(
                '[EbbotChatListener.onConnected] ------> Handling type: $type');
            var message = Message.fromJson(item);
            print(message);
            _onMessageCreated(message);
            break;
          case 'chat':
            print(
                '[EbbotChatListener.onConnected] ------> Handling type: $type');
            var chat = Chat.fromJson(item);
            print(chat);
            _onChatCreated(chat);
            break;
          default:
            // Handle unknown type
            print(
                '[EbbotChatListener.onConnected] ------> Unsupported type: $type');
            break;
        }
      }
    });

    // Subscribed!

    print("Subscribed!!!");

    var id = Uuid().v4();
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

    subscribe.emit("request.chat", publishdata);

    // extract this to a function

    /*new Timer.periodic(const Duration(seconds: 2), (_) {
      print('Attempting to send');
      socket.emit('sampleClientEvent',
          {'message': 'This is an object with a message property'});
    });*/
  }

  @override
  void onDisconnected(Socket socket) {
    print('onDisconnected: socket $socket');
  }

  @override
  void onSetAuthToken(String? token, Socket socket) {
    print('onSetAuthToken: socket $socket token $token');
    socket.authToken = token;
  }
}

class EbbotChatClient {
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
    print("[EbbotChatClient] initialize");
    var httpClient = EbbotHttpClient(this.botId, this.chatId);
    var result = await httpClient.initEbbot();
    print("[EbbotChatClient] Init Ebbot Result:$result");

    var chatId = result['data']['session']['chatId'];
    var botId = result['data']['session']['botId'];
    var session = result['data']['session']['session']; // What is it used for?
    var token = result['data']['token'];

    listener = EbbotChatListener(result, _messageStreamController, _chatStreamController);

    socket = await Socket.connect(
        'wss://v2.ebbot.app/api/asyngular/?botId=$botId&chatId=$chatId&token=$token',
        listener: listener);

    await _onSubscribed(); // Wait until we have subscribed
  }

  void dispose() {
    // TODO :We should probably close the socket here
    // We need to implement support for it in the Socket lib
    _chatStreamController.close();
    _messageStreamController.close();
  }

  Future<void> _onSubscribed() async {
    Completer<void> completer = Completer<void>();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      print("[_onSubscribed]");
      if (listener.hasSubscribed) {
        timer.cancel();
        completer.complete();
      }
    });

    return completer.future;
  }
}
