import 'dart:async';
import 'dart:convert';

import 'package:ebbot_dart_client/entity/session/session_init.dart';
import 'package:ebbot_dart_client/service/log_service.dart';
import 'package:ebbot_dart_client/src/network/base_http_client.dart';
import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class AsyngularHttpClient extends BaseHttpClient {
  final String _botId;
  final String _chatId;
  late HttpSession _httpSession;

  final logger = GetIt.instance<LogService>().logger;

  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  AsyngularHttpClient(this._botId, this._chatId, Environment environment)
      : super(environment);

  Future<HttpSession> initSession() async {
    final uri = getAPIUri("asyngular/init");
    final body = jsonEncode({"botId": _botId, "chatId": _chatId});
    logger?.i("Initializing session with uri $uri and body $body");
    final response = await http.post(uri, body: body, headers: ebbotAPIHeaders);
    logger?.i("Response from init session: ${response.body}");
    _httpSession = HttpSession.fromJson(json.decode(response.body));
    return _httpSession;
  }

  Future<void> endSession() async {
    final uri = getAPIUri("asyngular/end");
    logger?.i("Ending session with uri $uri");
    ebbotAPIHeaders['Authorization'] = "Bearer ${_httpSession.data.token}";
    final response = await http.get(uri, headers: ebbotAPIHeaders);
    logger?.i("Response from end session: ${response.body}");
  }
}
