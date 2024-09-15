import 'dart:async';

import 'package:ebbot_dart_client/entity/session/session_init.dart';
import 'package:ebbot_dart_client/service/asyngular_resolver_service.dart';
import 'package:ebbot_dart_client/service/log_service.dart';
import 'package:ebbot_dart_client/src/ebbot_chat_listener.dart';
import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:get_it/get_it.dart';
import 'package:socketcluster_client/socketcluster_client.dart';

class AsyngularWebsocketClient {
  final String _botId;
  final String _chatId;
  final Environment _environment;
  late Socket _socket;

  late EbbotChatListener _listener;

  final logger = GetIt.instance<LogService>().logger;

  AsyngularWebsocketClient(this._botId, this._chatId, this._environment);

  Future<Socket> initSocket(
      HttpSession httpSession, EbbotChatListener listener) async {
    _listener = listener;

    final url = AsyngularResolverService.resolveWs(_environment);
    final uri = Uri.parse(
        "$url/?botId=$_botId&chatId=$_chatId&token=${httpSession.data.token}");
    logger?.i("connecting to $uri");
    _socket = await Socket.connect(uri.toString(), listener: _listener);
    return _socket;
  }
}
