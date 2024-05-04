import 'package:logger/logger.dart';
import 'package:socketcluster_client/socketcluster_client.dart';
import 'package:uuid/uuid.dart';

class MessageHandler {
  final Socket _socket;
  final String _botId;
  final String _chatId;

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  MessageHandler(this._socket, this._botId, this._chatId);

  Map<String, dynamic> _generateMessage(String type, dynamic message) {
    var id = const Uuid().v4();
    var publishdata = {
      "clientId": _botId,
      "data": {
        "id": id,
        "chatId": _chatId,
        "finished": true,
        "sender": "user",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
        "type": type,
        "username": _chatId,
        "value": message,
      },
      "id": id,
      "event": "request.chat"
    };
    return publishdata;
  }

  void sendTextMessage(String message) {
    logger.i("Sending text message with message: $message");
    _socket.emit("request.chat", _generateMessage("text", message));
  }

  void sendUrlMessage(String url) {
    logger.i("Sending url message with url: $url");
    _socket.emit("request.chat", _generateMessage("url_click", url));
  }

  void sendRatingMessage(int rating) {
    logger.i("Sending rating message with rating: $rating");
    _socket.emit("request.chat", _generateMessage("rating", rating));
  }

  void sendScenarioMessage(String scenario) {
    logger.i("Sending scenario message with scenario: $scenario");
    _socket.emit("request.chat", _generateMessage("scenario", scenario));
  }

  void sendVariableMessage(String name, String value) {
    logger.i("Sending variable message with name: $name and value: $value");
    _socket.emit("request.chat",
        _generateMessage("variable", {"name": name, "value": value}));
  }

  void sendUpdateConversationInfo(Map<String, dynamic> conversationInfo) {
    logger.i("Sending conversation info update with info: $conversationInfo");
    _socket.emit("request.chat",
        _generateMessage("update_conversation_info", conversationInfo));
  }
}
