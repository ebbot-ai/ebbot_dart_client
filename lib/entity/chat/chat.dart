import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final String? type;
  final Map<String, dynamic>? data;
  final String? requestId;

  Chat({
    required this.type,
    required this.data,
    required this.requestId,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
