import 'dart:async';
import 'dart:convert';

import 'package:ebbot_dart_client/entities/session/session_init.dart';
import 'package:ebbot_dart_client/service/asyngular_resolver_service.dart';
import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:http/http.dart' as http;

class AsyngularHttpClient {
  final String _botId;
  final String _chatId;
  final Environment _environment;
  late HttpSession _httpSession;

  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  AsyngularHttpClient(this._botId, this._chatId, this._environment);

  Future<HttpSession> initSession() async {
    final url = AsyngularResolverService.resolveHttps(_environment);
    final uri = Uri.parse("$url/init");
    final body = jsonEncode({"botId": _botId, "chatId": _chatId});
    final response = await http.post(uri, body: body, headers: ebbotAPIHeaders);
    _httpSession = HttpSession.fromJson(json.decode(response.body));
    return _httpSession;
  }
}
