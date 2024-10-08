import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String type;
  final MessageData data;
  final String requestId;

  Message({
    required this.type,
    required this.data,
    required this.requestId,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class MessageData {
  final MessageContent message;

  MessageData({required this.message});

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}

@JsonSerializable()
class MessageContent {
  final String?
      id; // ID can be omitted if the type is button_click for some reason..
  final String botId;
  final String chatId;
  final String companyId;
  final String sender;
  final dynamic value;
  final String timestamp;
  final String? input_field; // Can be "visible", "hidden", "disabled" or null
  // type: gpt, url, etc (it will affect the data structure of value)
  final String type;
  final Map<String, dynamic>? conversation;

  MessageContent({
    required this.id,
    required this.botId,
    required this.chatId,
    required this.companyId,
    required this.sender,
    required this.value,
    required this.timestamp,
    required this.type,
    required this.input_field,
    this.conversation,
  });

  factory MessageContent.fromJson(Map<String, dynamic> json) =>
      _$MessageContentFromJson(json);

  Map<String, dynamic> toJson() => _$MessageContentToJson(this);
}
