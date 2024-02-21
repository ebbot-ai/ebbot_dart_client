// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      type: json['type'] as String,
      data: MessageData.fromJson(json['data'] as Map<String, dynamic>),
      requestId: json['requestId'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'requestId': instance.requestId,
    };

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      message: MessageContent.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

MessageContent _$MessageContentFromJson(Map<String, dynamic> json) =>
    MessageContent(
      id: json['id'] as String,
      botId: json['botId'] as String,
      chatId: json['chatId'] as String,
      companyId: json['companyId'] as String,
      sender: json['sender'] as String,
      value: json['value'],
      timestamp: json['timestamp'] as String,
      type: json['type'] as String,
      conversation: json['conversation'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MessageContentToJson(MessageContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'botId': instance.botId,
      'chatId': instance.chatId,
      'companyId': instance.companyId,
      'sender': instance.sender,
      'value': instance.value,
      'timestamp': instance.timestamp,
      'type': instance.type,
      'conversation': instance.conversation,
    };
