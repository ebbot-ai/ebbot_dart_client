import 'dart:async';
import 'dart:convert';

import 'package:ebbot_dart_client/entities/session/session_init.dart';
import 'package:http/http.dart' as http;

class AsyngularHttpClient {
  final String asyngularHttpBaseUrl = "https://v2.ebbot.app/api/asyngular";
  final String _botId;
  final String _chatId;
  late HttpSession _httpSession;

  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  AsyngularHttpClient(this._botId, this._chatId);

  Future<HttpSession> init() async {
    try {
      final url = Uri.parse("$asyngularHttpBaseUrl/init");
      final body = jsonEncode({"botId": _botId, "chatId": _chatId});
      final response =
          await http.post(url, body: body, headers: ebbotAPIHeaders);
      _httpSession = HttpSession.fromJson(json.decode(response.body));
      return _httpSession;
    } catch (e) {
      rethrow;
    }
  }
}
