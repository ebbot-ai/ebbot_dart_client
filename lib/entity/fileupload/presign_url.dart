import 'package:json_annotation/json_annotation.dart';

part 'presign_url.g.dart';

@JsonSerializable()
class PresignUrl {
  final bool success;
  final String data;
  @JsonKey(name: 'request_id')
  final String requestId;

  PresignUrl({
    required this.success,
    required this.data,
    required this.requestId,
  });

  factory PresignUrl.fromJson(Map<String, dynamic> json) =>
      _$PresignUrlFromJson(json);

  Map<String, dynamic> toJson() => _$PresignUrlToJson(this);
}
