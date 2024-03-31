// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_init.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpSession _$SessionInitFromJson(Map<String, dynamic> json) => HttpSession(
      data: SessionData.fromJson(json['data'] as Map<String, dynamic>),
      existing: json['existing'] as bool,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$SessionInitToJson(HttpSession instance) =>
    <String, dynamic>{
      'data': instance.data,
      'existing': instance.existing,
      'success': instance.success,
    };

SessionData _$SessionDataFromJson(Map<String, dynamic> json) => SessionData(
      session: Session.fromJson(json['session'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$SessionDataToJson(SessionData instance) =>
    <String, dynamic>{
      'session': instance.session,
      'token': instance.token,
    };

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      botId: json['botId'] as String,
      chatId: json['chatId'] as String,
      session: json['session'] as String,
      expires: json['expires'] as int,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'botId': instance.botId,
      'chatId': instance.chatId,
      'session': instance.session,
      'expires': instance.expires,
    };
