import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final String type;
  final ChatData data;
  final String requestId;

  Chat({
    required this.type,
    required this.data,
    required this.requestId,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class ChatData {
  final ChatContent chat;

  ChatData({required this.chat});

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataToJson(this);
}

@JsonSerializable()
class ChatContent {
  final String id;
  final String companyId;
  final String botId;
  @JsonKey(name: 'integration_type')
  final String integrationType;
  final String status;
  final String statusTimestamp;
  final String language;
  final String chatUserId;
  final String name;
  final String type;
  @JsonKey(name: 'handled_by')
  final String handledBy;
  final List<dynamic> agents;
  @JsonKey(name: 'new_messages')
  final int newMessages;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: 'last_message')
  final String lastMessage;

  ChatContent({
    required this.id,
    required this.companyId,
    required this.botId,
    required this.integrationType,
    required this.status,
    required this.statusTimestamp,
    required this.language,
    required this.chatUserId,
    required this.name,
    required this.type,
    required this.handledBy,
    required this.agents,
    required this.newMessages,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
  });

  factory ChatContent.fromJson(Map<String, dynamic> json) =>
      _$ChatContentFromJson(json);

  Map<String, dynamic> toJson() => _$ChatContentToJson(this);
}
