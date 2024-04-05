import 'package:json_annotation/json_annotation.dart';

part 'session_init.g.dart';

@JsonSerializable()
class HttpSession {
  final SessionData data;
  final bool existing;
  final bool success;

  HttpSession({
    required this.data,
    required this.existing,
    required this.success,
  });

  factory HttpSession.fromJson(Map<String, dynamic> json) =>
      _$HttpSessionFromJson(json);

  Map<String, dynamic> toJson() => _$HttpSessionToJson(this);
}

@JsonSerializable()
class SessionData {
  final Session session;
  final String token;

  SessionData({required this.session, required this.token});

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDataToJson(this);
}

@JsonSerializable()
class Session {
  final String botId;
  final String chatId;
  final String session;
  final int expires;

  Session({
    required this.botId,
    required this.chatId,
    required this.session,
    required this.expires,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
