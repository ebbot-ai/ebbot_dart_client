// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      type: json['type'] as String,
      data: ChatData.fromJson(json['data'] as Map<String, dynamic>),
      requestId: json['requestId'] as String,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'requestId': instance.requestId,
    };

ChatData _$ChatDataFromJson(Map<String, dynamic> json) => ChatData(
      chat: ChatContent.fromJson(json['chat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatDataToJson(ChatData instance) => <String, dynamic>{
      'chat': instance.chat,
    };

ChatContent _$ChatContentFromJson(Map<String, dynamic> json) => ChatContent(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      botId: json['botId'] as String,
      integrationType: json['integration_type'] as String,
      status: json['status'] as String,
      statusTimestamp: json['statusTimestamp'] as String,
      language: json['language'] as String,
      chatUserId: json['chatUserId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      handledBy: json['handled_by'] as String,
      agents: json['agents'] as List<dynamic>,
      newMessages: json['new_messages'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      lastMessage: json['last_message'] as String,
    );

Map<String, dynamic> _$ChatContentToJson(ChatContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'botId': instance.botId,
      'integration_type': instance.integrationType,
      'status': instance.status,
      'statusTimestamp': instance.statusTimestamp,
      'language': instance.language,
      'chatUserId': instance.chatUserId,
      'name': instance.name,
      'type': instance.type,
      'handled_by': instance.handledBy,
      'agents': instance.agents,
      'new_messages': instance.newMessages,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'last_message': instance.lastMessage,
    };
