import 'dart:async';
import 'dart:convert';

import 'package:ebbot_dart_client/entities/session/session_init.dart';
import 'package:ebbot_dart_client/src/ebbot_chat_listener.dart';
import 'package:logger/logger.dart';
import 'package:socketcluster_client/socketcluster_client.dart';
import 'package:http/http.dart' as http;

class AsyngularClient {
  final asyngularWSBaseUrl = 'wss://v2.ebbot.app/api/asyngular';
  final String asyngularHttpBaseUrl = "https://v2.ebbot.app/api/asyngular";
  final String _token = "";
  final String _botId;
  final String _chatId;
  late EbbotChatListener _listener;

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  late Socket _socket;
  Socket get socket => _socket;

  late HttpSession _httpSession;
  HttpSession get httpSession => _httpSession;

  AsyngularClient(this._botId, this._chatId);

  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  Future<HttpSession> initHTTPSession() async {
    try {
      final url = Uri.parse("$asyngularHttpBaseUrl/init");
      final body = jsonEncode({"botId": _botId, "chatId": _chatId});
      final response =
          await http.post(url, body: body, headers: ebbotAPIHeaders);
      _httpSession = HttpSession.fromJson(json.decode(response.body));
      return _httpSession;
    } catch (e) {
      logger.e("Error initializing session: $e");
      rethrow;
    }
  }

  Future<Socket> initWebsocket(EbbotChatListener listener) async {
    _listener = listener;
    try {
      final url = Uri.parse(
          "$asyngularWSBaseUrl/?botId=$_botId&chatId=$_chatId&token=${_httpSession.data.token}");
      _socket = await Socket.connect(url.toString(), listener: _listener);
      return _socket;
    } catch (e) {
      logger.e("Error initializing websocket: $e");
      rethrow;
    }
  }
}
