import 'package:ebbot_dart_client/entities/chat_config/chat_config.dart';
import 'package:ebbot_dart_client/entities/session/session_init.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EbbotHttpClient {
  final String apiBaseUrl = "https://v2.ebbot.app/api/asyngular";
  final String configBaseUrl = "https://ebbot-v2.storage.googleapis.com/configs";

  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  final Logger logger = Logger(printer: PrettyPrinter());

  String botId;
  String chatId;

  EbbotHttpClient(this.botId, this.chatId);

  Future<SessionInit> initSession() async {
    try {
      final url = Uri.parse("$apiBaseUrl/init");
      final body = jsonEncode({"botId": botId, "chatId": chatId});
      final response = await http.post(url, body: body, headers: ebbotAPIHeaders);
      return SessionInit.fromJson(json.decode(response.body));
    } catch (e) {
      logger.e("Error initializing session: $e");
      rethrow;
    }
  }

  Future<ChatConfig> fetchConfig() async {
    try {
      final url = Uri.parse("$configBaseUrl/$botId.json?t=${DateTime.now().millisecondsSinceEpoch}");
      final response = await http.get(url, headers: {'Accept-Charset': 'utf-8'});
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(decodedBody);
      return ChatConfig.fromJson(jsonResponse);
    } catch (e) {
      logger.e("Error fetching config: $e");
      rethrow;
    }
  }
}