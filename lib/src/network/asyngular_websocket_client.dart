import 'dart:async';

import 'package:ebbot_dart_client/service/log_service.dart';
import 'package:ebbot_dart_client/src/ebbot_chat_listener.dart';
import 'package:ebbot_dart_client/src/network/base_http_client.dart';
import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:get_it/get_it.dart';
import 'package:socketcluster_client/socketcluster_client.dart';

class AsyngularWebsocketClient extends BaseHttpClient {
  final String _botId;
  final String _chatId;
  late Socket _socket;

  late EbbotChatListener _listener;

  final logger = GetIt.instance<LogService>().logger;

  AsyngularWebsocketClient(this._botId, this._chatId, Environment environment)
      : super(environment);

  Future<Socket> initSocket(String token, EbbotChatListener listener) async {
    _listener = listener;

    final uri =
        getWSUri("asyngular/?botId=$_botId&chatId=$_chatId&token=$token");
    logger?.i("connecting to $uri");
    _socket = await Socket.connect(uri.toString(), listener: _listener);
    return _socket;
  }
}
