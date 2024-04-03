import 'package:ebbot_dart_client/configuration/environment_configuration_config.dart';
import 'package:ebbot_dart_client/entities/chat_config/chat_config.dart';
import 'package:logger/logger.dart';
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
    var configBaseUrl = EnvironmentConfigurationConfig.getConfigUrl(env);
    final uri = Uri.parse(
        "$configBaseUrl$botId.json?t=${DateTime.now().millisecondsSinceEpoch}");
    logger.i("Fetching config from environment $env and uri $uri");

    // First try to fetch the config for the given environment
    var config = await _fetchConfig(env);
    if (config != null) {
      return config;
    }
    
    // Then try to fetch the config for all the other environments
    for (var host in EnvironmentConfigurationConfig.baseUrls.keys) {
      var config = await _fetchConfig(host);
      if (config != null) {
        return config;
      }
    }

    throw Exception("Failed to fetch config for env $env at uri $uri");
  }

  Future<ChatConfig?> _fetchConfig(Environment env) async {
    var configBaseUrl = EnvironmentConfigurationConfig.getConfigUrl(env);
    final uri = Uri.parse(
        "$configBaseUrl$botId.json?t=${DateTime.now().millisecondsSinceEpoch}");
    try {
      final response =
          await http.get(uri, headers: {'Accept-Charset': 'utf-8'});

      if (response.statusCode < 200 || response.statusCode >= 300) {
        logger.w("Failed to fetch config for env $env at uri $uri");
        return null;
      }

      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(decodedBody);
      return ChatConfig.fromJson(jsonResponse);
    } catch (e) {
      logger.e("Error fetching config for env $env at uri $uri: $e");
      return null;
    }
  }
}
