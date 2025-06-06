import 'dart:convert';

import 'package:ebbot_dart_client/entity/chat_config/chat_config.dart';
import 'package:ebbot_dart_client/entity/chat_config/chat_style_v2_config.dart';
import 'package:ebbot_dart_client/service/config_resolver_service.dart';
import 'package:ebbot_dart_client/service/log_service.dart';
import 'package:ebbot_dart_client/valueobjects/environment.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class EbbotHttpClient {
  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  final logger = GetIt.instance<LogService>().logger;

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

  Future<(ChatConfig, ChatStyleConfigV2?)> fetchConfigs() async {
    final chatConfig = await fetchConfig();
    final maybeChatStyleConfigID = chatConfig.maybeGetChatStyleConfig();
    if (maybeChatStyleConfigID != null) {
      final chatStyleConfig =
          await fetchChatStyleConfig(maybeChatStyleConfigID);
      return (chatConfig, chatStyleConfig);
    }

    return (chatConfig, null);
  }

  Future<ChatConfig> fetchConfig() async {
    var configBaseUrl = ConfigResolverService.resolve(env);
    final uri = Uri.parse(
        "$configBaseUrl$botId.json?t=${DateTime.now().millisecondsSinceEpoch}");
    logger?.i("Fetching config from environment $env and uri $uri");

    // First try to fetch the config for the given environment
    var config = await _fetchConfig(env);
    if (config != null) {
      return config;
    }

    throw Exception("Failed to fetch config for env $env at uri $uri");
  }

  Future<ChatStyleConfigV2> fetchChatStyleConfig(String chatStyleId) async {
    var configBaseUrl = ConfigResolverService.resolve(env);
    final uri = Uri.parse(
        "$configBaseUrl$botId-$chatStyleId.json?t=${DateTime.now().millisecondsSinceEpoch}");
    logger?.i("Fetching chat style config from uri $uri");

    try {
      final response =
          await http.get(uri, headers: {'Accept-Charset': 'utf-8'});

      if (response.statusCode < 200 || response.statusCode >= 300) {
        logger?.w("Failed to fetch chat style config at uri $uri");
        throw Exception("Failed to fetch chat style config at uri $uri");
      }

      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(decodedBody);
      return ChatStyleConfigV2.fromJson(jsonResponse);
    } catch (e) {
      logger?.e("Error fetching chat style config at uri $uri: $e");
      throw e;
    }
  }

  Future<ChatConfig?> _fetchConfig(Environment env) async {
    var configBaseUrl = ConfigResolverService.resolve(env);
    final uri = Uri.parse(
        "$configBaseUrl$botId.json?t=${DateTime.now().millisecondsSinceEpoch}");
    try {
      final response =
          await http.get(uri, headers: {'Accept-Charset': 'utf-8'});

      if (response.statusCode < 200 || response.statusCode >= 300) {
        logger?.w("Failed to fetch config for env $env at uri $uri");
        return null;
      }

      final decodedBody = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(decodedBody);
      return ChatConfig.fromJson(jsonResponse);
    } catch (e) {
      logger?.e("Error fetching config for env $env at uri $uri: $e");

      return null;
    }
  }
}
