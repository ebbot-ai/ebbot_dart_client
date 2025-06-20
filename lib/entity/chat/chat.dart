import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable(explicitToJson: true)
class Chat {
  final String? type;
  final ChatData? data;
  final String? requestId;

  Chat({
    required this.type,
    required this.data,
    required this.requestId,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChatData {
  final ChatContent? chat;
  final String? token;

  ChatData({
    this.chat,
    this.token,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChatContent {
  final List<ChatMessage>? chat_messages;
  final String? handled_by;
  final String? user_profile_picture;
  final String? type;
  final String? status;

  ChatContent({
    this.chat_messages,
    this.handled_by,
    this.user_profile_picture,
    this.type,
    this.status,
  });

  factory ChatContent.fromJson(Map<String, dynamic> json) =>
      _$ChatContentFromJson(json);

  Map<String, dynamic> toJson() => _$ChatContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChatMessage {
  final String? id;
  final String? sender;
  final dynamic value;
  final String? timestamp;
  final String? chatId;
  final String? botId;
  final String? companyId;
  final String? type;
  final dynamic semanticRole;
  final String? status;
  final String? visibility;
  final String? scenarioId;
  final dynamic userId;
  final bool? sanitized;
  final dynamic rating;
  final List<dynamic>? tags;

  // Note: The JSON contains duplicate snake_case keys.
  // You can either map them to the same property or ignore them.
  @JsonKey(name: 'chat_id')
  final String? chatIdSnake;
  @JsonKey(name: 'scenario_id')
  final String? scenarioIdSnake;
  @JsonKey(name: 'user_id')
  final String? userIdSnake;
  @JsonKey(name: 'bot_id')
  final String? botIdSnake;
  @JsonKey(name: 'company_id')
  final String? companyIdSnake;

  ChatMessage({
    this.id,
    this.sender,
    this.value,
    this.timestamp,
    this.chatId,
    this.botId,
    this.companyId,
    this.type,
    this.semanticRole,
    this.status,
    this.visibility,
    this.scenarioId,
    this.userId,
    this.sanitized,
    this.rating,
    this.tags,
    this.chatIdSnake,
    this.scenarioIdSnake,
    this.userIdSnake,
    this.botIdSnake,
    this.companyIdSnake,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
