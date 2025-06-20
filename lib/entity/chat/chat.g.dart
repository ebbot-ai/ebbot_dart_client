// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      type: json['type'] as String?,
      data: json['data'] == null
          ? null
          : ChatData.fromJson(json['data'] as Map<String, dynamic>),
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'type': instance.type,
      'data': instance.data?.toJson(),
      'requestId': instance.requestId,
    };

ChatData _$ChatDataFromJson(Map<String, dynamic> json) => ChatData(
      chat: json['chat'] == null
          ? null
          : ChatContent.fromJson(json['chat'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ChatDataToJson(ChatData instance) => <String, dynamic>{
      'chat': instance.chat?.toJson(),
      'token': instance.token,
    };

ChatContent _$ChatContentFromJson(Map<String, dynamic> json) => ChatContent(
      chat_messages: (json['chat_messages'] as List<dynamic>?)
          ?.map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      handled_by: json['handled_by'] as String?,
      user_profile_picture: json['user_profile_picture'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ChatContentToJson(ChatContent instance) =>
    <String, dynamic>{
      'chat_messages': instance.chat_messages?.map((e) => e.toJson()).toList(),
      'handled_by': instance.handled_by,
      'user_profile_picture': instance.user_profile_picture,
      'type': instance.type,
      'status': instance.status,
    };

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      id: json['id'] as String?,
      sender: json['sender'] as String?,
      value: json['value'],
      timestamp: json['timestamp'] as String?,
      chatId: json['chatId'] as String?,
      botId: json['botId'] as String?,
      companyId: json['companyId'] as String?,
      type: json['type'] as String?,
      semanticRole: json['semanticRole'],
      status: json['status'] as String?,
      visibility: json['visibility'] as String?,
      scenarioId: json['scenarioId'] as String?,
      userId: json['userId'],
      sanitized: json['sanitized'] as bool?,
      rating: json['rating'],
      tags: json['tags'] as List<dynamic>?,
      chatIdSnake: json['chat_id'] as String?,
      scenarioIdSnake: json['scenario_id'] as String?,
      userIdSnake: json['user_id'] as String?,
      botIdSnake: json['bot_id'] as String?,
      companyIdSnake: json['company_id'] as String?,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'value': instance.value,
      'timestamp': instance.timestamp,
      'chatId': instance.chatId,
      'botId': instance.botId,
      'companyId': instance.companyId,
      'type': instance.type,
      'semanticRole': instance.semanticRole,
      'status': instance.status,
      'visibility': instance.visibility,
      'scenarioId': instance.scenarioId,
      'userId': instance.userId,
      'sanitized': instance.sanitized,
      'rating': instance.rating,
      'tags': instance.tags,
      'chat_id': instance.chatIdSnake,
      'scenario_id': instance.scenarioIdSnake,
      'user_id': instance.userIdSnake,
      'bot_id': instance.botIdSnake,
      'company_id': instance.companyIdSnake,
    };
