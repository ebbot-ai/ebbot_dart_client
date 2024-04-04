import 'dart:async';

import 'package:ebbot_dart_client/entities/session/session_init.dart';
import 'package:ebbot_dart_client/src/ebbot_chat_listener.dart';
import 'package:logger/logger.dart';
import 'package:socketcluster_client/socketcluster_client.dart';

class AsyngularWebsocketClient {
  final String asyngularWSBaseUrl = 'wss://v2.ebbot.app/api/asyngular';
  final String _botId;
  final String _chatId;
  late Socket _socket;
  late EbbotChatListener _listener;

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  AsyngularWebsocketClient(this._botId, this._chatId);

  Future<Socket> init(
      HttpSession httpSession, EbbotChatListener listener) async {
    _listener = listener;
    try {
      final url = Uri.parse(
          "$asyngularWSBaseUrl/?botId=$_botId&chatId=$_chatId&token=${httpSession.data.token}");
      logger.i("connecting to $url");
      _socket = await Socket.connect(url.toString(), listener: _listener);
      return _socket;
    } catch (e) {
      rethrow;
    }
  }
}
