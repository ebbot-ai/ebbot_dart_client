library ebbot_chat;

import 'dart:async';

import 'package:ebbot_dart_client/configuration/configuration.dart';
import 'package:ebbot_dart_client/entity/button_data/button_data.dart';
import 'package:ebbot_dart_client/entity/chat/chat.dart';
import 'package:ebbot_dart_client/entity/chat_config/chat_config.dart';
import 'package:ebbot_dart_client/entity/chat_config/chat_style_v2_config.dart';
import 'package:ebbot_dart_client/entity/fileupload/image_response.dart';
import 'package:ebbot_dart_client/entity/message/message.dart';
import 'package:ebbot_dart_client/entity/session/session_init.dart';
import 'package:ebbot_dart_client/service/log_service.dart';
import 'package:ebbot_dart_client/service/websocket_service.dart';
import 'package:ebbot_dart_client/src/network/asyngular_http_client.dart';
import 'package:ebbot_dart_client/src/network/ebbot_http_client.dart';
import 'package:ebbot_dart_client/src/network/fileupload_http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:socketcluster_client/socketcluster_client.dart';
import 'package:uuid/uuid.dart';

class EbbotDartClient {
  late Logger? _logger;

  final String _botId;
  final Configuration _configuration;

  late EbbotHttpClient _ebbotHttpClient;
  late HttpSession _httpSession;
  // ignore: unused_field
  late Socket _socket;
  late ChatConfig _chatConfig;
  late ChatStyleConfigV2?
      _chatStyleConfig; // This might be null if no chat style config is available
  late AsyngularHttpClient _asyngularHttpClient;
  late FileUploadHttpClient _fileUploadHttpClient;

  late String _chatId;

  WebSocketService get _webSocketService => GetIt.I<WebSocketService>();
  Stream<Message> get messageStream => _webSocketService.messageStream;
  Stream<Chat> get chatStream => _webSocketService.chatStream;
  HttpSession get session => _httpSession;
  ChatStyleConfigV2? get chatStyleConfig => _chatStyleConfig;

  EbbotDartClient(this._botId, this._configuration) {
    if (!GetIt.I.isRegistered<Configuration>()) {
      GetIt.I.registerSingleton<Configuration>(_configuration);
    }
    if (!GetIt.I.isRegistered<LogService>()) {
      GetIt.I.registerSingleton<LogService>(LogService());
    }

    if (!GetIt.I.isRegistered<WebSocketService>()) {
      GetIt.I.registerSingleton<WebSocketService>(
          WebSocketService(_botId, _configuration));
    }

    _logger = GetIt.I<LogService>().logger;
  }

  // Public init methods

  Future<void> initialize() async {
    _logger?.i("initialize");

    _initChatId();
    _initEbbotHttpClient();
    await _initConfigs();
    _handleChatStyleConfig();
    await _initializeHttpClients();
  }

  // This method is used to initialize the WebSocket connection
  // after the HTTP session has been initialized.
  // the subsequent call would be the startReceive method
  Future<void> initializeWebsocketConnection() async {
    await _webSocketService.connect(_httpSession.data.token, _chatId);

    // Hack to get the token from the web_init call
    _webSocketService.chatStream.listen(_onChatStreamMessage);
  }

  // Private init methods

  void _initChatId() {
    final sessionConfig = _configuration.sessionConfiguration;
    _chatId = "${DateTime.now().millisecondsSinceEpoch}-${const Uuid().v4()}";

    if (sessionConfig.chatId != null) {
      _logger?.i("Using chatId from session config: ${sessionConfig.chatId}");
      _chatId = sessionConfig.chatId!;
    }
  }

  void _initEbbotHttpClient() {
    final environment = _configuration.environment;
    _ebbotHttpClient = EbbotHttpClient(
      botId: _botId,
      chatId: _chatId,
      env: environment,
    );
  }

  Future<void> _initConfigs() async {
    _logger?.i("Fetching configuration from server");

    final (chatConfig, chatStyleConfig) = await _ebbotHttpClient.fetchConfigs();
    _chatConfig = chatConfig;
    _chatStyleConfig = chatStyleConfig;
    _logger?.i("Successfully fetched configuration from server");
  }

  void _handleChatStyleConfig() {
    if (_chatConfig.maybeGetChatStyleConfig() != null) {
      _logger?.i("Chat style config: ${_chatConfig.chat_style}");
    } else {
      _logger?.w("No chat style config found in the fetched configuration");
    }
  }

  Future<void> _initializeHttpClients() async {
    final environment = _configuration.environment;
    _asyngularHttpClient = AsyngularHttpClient(_botId, _chatId, environment);
    _httpSession = await _asyngularHttpClient.initSession();
    _fileUploadHttpClient = FileUploadHttpClient(environment);
  }

  void _onChatStreamMessage(Chat chat) {
    // We only care about if the token has been received.
    // Its only used when uploading files for now
    //final String? token = chat.data?['token'];
    final String? token = chat.data?.token;
    if (token != null) {
      _logger?.i("Received token from chat stream: $token");
      _fileUploadHttpClient.token = token;
    }
  }

  void startReceive() {
    // Dispatch any scenarios as a message from the chatbot
    var answers = _chatConfig.scenario.answers;

    for (var answer in answers) {
      // This is somewhat a hack to emulate that the bot is in fact sending a message
      _logger?.i("dispatching answer: ${answer.value}");
      _webSocketService.sendBotMessageFromAnswer(answer);
    }
  }

  Future<void> closeAsync({bool endSession = false}) async {
    await _webSocketService.closeAsync();
    if (endSession) {
      await _asyngularHttpClient.endSession();
    }
  }

  void sendTextMessage(String message, {ButtonData? buttonData}) {
    _webSocketService.sendTextMessage(message, buttonData);
  }

  void sendUrlMessage(String url, {ButtonData? buttonData}) {
    _webSocketService.sendUrlMessage(url, buttonData);
  }

  void sendRatingMessage(int rating, {ButtonData? buttonData}) {
    _webSocketService.sendRatingMessage(rating, buttonData);
  }

  void sendScenarioMessage(String scenario,
      {String? state, ButtonData? buttonData}) {
    _webSocketService.sendScenarioMessage(scenario, state, buttonData);
  }

  void sendVariableMessage(String name, String value,
      {ButtonData? buttonData}) {
    _webSocketService.sendVariableMessage(name, value, buttonData);
  }

  void sendUpdateConversationInfoMessage(Map<String, dynamic> conversationInfo,
      {ButtonData? buttonData}) {
    _webSocketService.sendUpdateConversationInfoMessage(
        conversationInfo, buttonData);
  }

  void sendButtonClickedMessage(ButtonData buttonData) {
    _webSocketService.sendButtonClickedMessage(buttonData);
  }

  void sendCloseChatMessage() {
    _webSocketService.sendCloseChatMessage();
  }

  Future<void> uploadImage(imageBytes, String filePath) async {
    ImageResponse imageResponse =
        await _fileUploadHttpClient.uploadImage(imageBytes, filePath);

    _webSocketService.sendImageMessage(imageResponse);
  }
}
