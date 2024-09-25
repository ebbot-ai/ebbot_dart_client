// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presign_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresignUrl _$PresignUrlFromJson(Map<String, dynamic> json) => PresignUrl(
      success: json['success'] as bool,
      data: json['data'] as String,
      requestId: json['request_id'] as String,
    );

Map<String, dynamic> _$PresignUrlToJson(PresignUrl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'request_id': instance.requestId,
    };
