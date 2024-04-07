import 'dart:io';

import 'package:ebbot_dart_client/entities/chat_config/chat_config.dart';
import 'package:ebbot_dart_client/service/config_resolver_service.dart';
import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';

class EbbotHttpClient {
  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  final Logger logger = Logger(printer: PrettyPrinter(lineLength: 2000));

  String botId;
  String chatId;
  Environment env;
  http.Client httpClient;

  EbbotHttpClient({
    required this.botId,
    required this.chatId,
    required this.env,
    http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  Future<ChatConfig> fetchConfig() async {
    var configBaseUrl = ConfigResolverService.resolve(env);
    final uri = Uri.parse(
        "$configBaseUrl$botId.json?t=${DateTime.now().millisecondsSinceEpoch}");
    logger.i("Fetching config from environment $env and uri $uri");

    // First try to fetch the config for the given environment
    var config = await _fetchConfig(env);
    if (config != null) {
      return config;
    }

    logger.w(
        "Provided environment $env does not have a config at uri $uri, using fallback mechanism");

    // Then try to fetch the config for all the other environments
    var hosts = ConfigResolverService.baseUrls.keys
        .where((configEnv) => configEnv != env);
    for (var host in hosts) {
      var config = await _fetchConfig(host);
      if (config != null) {
        logger.i("Found config for env $host at uri $uri");
        return config;
      }
      logger.w("Failed to fetch config for env $host at uri $uri, trying next");
    }

    throw Exception("Failed to fetch config for env $env at uri $uri");
  }

  Future<ChatConfig?> _fetchConfig(Environment env) async {
    var configBaseUrl = ConfigResolverService.resolve(env);
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
