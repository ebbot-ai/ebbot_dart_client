// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      type: json['type'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'requestId': instance.requestId,
    };
