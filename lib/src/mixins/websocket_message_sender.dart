import 'package:ebbot_dart_client/entity/button_data/button_data.dart';
import 'package:ebbot_dart_client/entity/fileupload/image_response.dart';
import 'package:ebbot_dart_client/service/websocket_service.dart';
import 'package:get_it/get_it.dart';

mixin WebSocketMessageSender {
  WebSocketService get _webSocketService => GetIt.I<WebSocketService>();

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

  void sendImageMessage(ImageResponse imageResponse) {
    _webSocketService.sendImageMessage(imageResponse);
  }
}