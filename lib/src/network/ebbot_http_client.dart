import 'package:ebbot_dart_client/configuration/environment_config.dart';
import 'package:ebbot_dart_client/entities/chat_config/chat_config.dart';
import 'package:ebbot_dart_client/entities/session/session_init.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EbbotHttpClient {
  final String apiBaseUrl = "https://v2.ebbot.app/api/asyngular";

  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  final Logger logger = Logger(printer: PrettyPrinter());

  String botId;
  String chatId;

  EbbotHttpClient(this.botId, this.chatId);

  Future<ChatConfig> fetchConfig(Environment env) async {
    var configBaseUrl = EnvironmentConfig.getConfigUrl(env);
    final uri = Uri.parse(
        "$configBaseUrl$botId.json?t=${DateTime.now().millisecondsSinceEpoch}");
    logger.i("Fetching config from environment $env and uri $uri");

    try {
      final response =
          await http.get(uri, headers: {'Accept-Charset': 'utf-8'});
      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(decodedBody);
      return ChatConfig.fromJson(jsonResponse);
    } catch (e) {
      logger.e("Error fetching config for env $env at uri $uri: $e");
      rethrow;
    }
  }
}
