import 'package:ebbot_dart_client/entities/chat_config.dart';
import 'package:ebbot_dart_client/entities/session_init.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EbbotHttpClient {
  final apiBaseUrl = "https://v2.ebbot.app/api/asyngular";
  final configBaseUrl = "https://ebbot-v2.storage.googleapis.com/configs";

  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  String botId;
  String chatId;

  EbbotHttpClient(this.botId, this.chatId);

  Future<SessionInit> initEbbot() async {
    var url = "$apiBaseUrl/init";
    print("initEbbot URL!: $url");
    var body = {"botId": botId, "chatId": chatId};
    var uri = Uri.parse(url);
    var response =
        await http.post(uri, body: jsonEncode(body), headers: ebbotAPIHeaders);

    return SessionInit.fromJson(json.decode(response.body));
  }

  Future<ChatConfig> fetchConfig() async {
    var url = "$configBaseUrl/$botId.json?t=${DateTime.now().millisecondsSinceEpoch}";
    print("fetchConfig URL!: $url");
    var uri = Uri.parse(url);
    var response =
        await http.get(uri, headers: {'Accept-Charset': 'utf-8'});

    final decodedBody = utf8.decode(response.bodyBytes);
    // Decode the response to a ChatStyle instance
    final jsonResponse = json.decode(decodedBody);
    return ChatConfig.fromJson(jsonResponse);
  }
}
