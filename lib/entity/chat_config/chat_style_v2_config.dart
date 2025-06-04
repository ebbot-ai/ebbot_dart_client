import 'package:json_annotation/json_annotation.dart';

part 'chat_style_v2_config.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatStyleConfigV2 {
  final Logo logo;
  final Avatar avatar;
  final bool footer;
  final bool auto_open;
  final bool hide_chat;
  final bool sound_bot;
  final String spam_text;
  final FontType text_font;
  final FontType title_font;
  final String arrow_color;
  final String? blobCTAText; // Missing in some configs
  final BubbleIcon bubble_icon;
  final bool global_font;
  final String header_text;
  final String sign_in_url;
  final String bubble_color;
  final String header_color;
  final String header_title;
  final bool? logo_enabled; // Missing in some configs
  final String sign_in_text;
  final bool alert_enabled;
  final ChatLanguage chat_language;
  final String chat_position;
  final MessageDelay message_delay;
  final bool positionFixed;
  final String placeholder_text;
  final bool auto_open_mobile;
  final bool sign_in_enabled;
  final bool agent_chat_sound;
  final bool show_agent_typing;
  final String chat_window_height;
  final bool client_read_status;
  final bool agent_in_transcript;
  final bool chat_fixed_position;
  final String chat_mobile_position;
  final String chat_position_offset;
  final bool info_section_enabled;
  final String info_section_title;
  final String info_section_text;
  final bool info_section_in_conversation;
  final String regular_btn_background_color;
  final String regular_btn_text_color;
  final String? start_page_footer;
  final bool? avatar_enabled; // Missing in some configs
  final bool? start_page_enabled;
  final List<StartPageLinkCard> start_page_link_cards;
  final String icon_plate_color;
  final String icon_icon_color;
  final TimeWindow? alert_time_window;
  final String message_dots_color;
  final String btn_clicked_text_color;
  final String btn_clicked_background_color;

  ChatStyleConfigV2({
    required this.logo,
    required this.avatar,
    required this.footer,
    required this.auto_open,
    required this.hide_chat,
    required this.sound_bot,
    required this.spam_text,
    required this.text_font,
    required this.title_font,
    required this.arrow_color,
    required this.blobCTAText,
    required this.bubble_icon,
    required this.global_font,
    required this.header_text,
    required this.sign_in_url,
    required this.bubble_color,
    required this.header_color,
    required this.header_title,
    required this.logo_enabled,
    required this.sign_in_text,
    required this.alert_enabled,
    required this.chat_language,
    required this.chat_position,
    required this.message_delay,
    required this.positionFixed,
    required this.placeholder_text,
    required this.auto_open_mobile,
    required this.sign_in_enabled,
    required this.agent_chat_sound,
    required this.show_agent_typing,
    required this.chat_window_height,
    required this.client_read_status,
    required this.agent_in_transcript,
    required this.chat_fixed_position,
    required this.chat_mobile_position,
    required this.chat_position_offset,
    required this.info_section_enabled,
    required this.info_section_title,
    required this.info_section_text,
    required this.info_section_in_conversation,
    required this.start_page_footer,
    required this.avatar_enabled,
    required this.start_page_enabled,
    required this.regular_btn_background_color,
    required this.regular_btn_text_color,
    required this.start_page_link_cards,
    required this.icon_plate_color,
    required this.icon_icon_color,
    required this.message_dots_color,
    required this.btn_clicked_text_color,
    required this.btn_clicked_background_color,
    this.alert_time_window,
  });

  factory ChatStyleConfigV2.fromJson(Map<String, dynamic> json) =>
      _$ChatStyleConfigV2FromJson(json);

  Map<String, dynamic> toJson() => _$ChatStyleConfigV2ToJson(this);
}

@JsonSerializable()
class FontType {
  final String type;

  FontType({required this.type});

  factory FontType.fromJson(Map<String, dynamic> json) =>
      _$FontTypeFromJson(json);

  Map<String, dynamic> toJson() => _$FontTypeToJson(this);
}

@JsonSerializable()
class BubbleIcon {
  final String type;

  BubbleIcon({required this.type});

  factory BubbleIcon.fromJson(Map<String, dynamic> json) =>
      _$BubbleIconFromJson(json);

  Map<String, dynamic> toJson() => _$BubbleIconToJson(this);
}

@JsonSerializable()
class ChatLanguage {
  final String name;
  final String short_name;

  ChatLanguage({required this.name, required this.short_name});

  factory ChatLanguage.fromJson(Map<String, dynamic> json) =>
      _$ChatLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatLanguageToJson(this);
}

@JsonSerializable()
class MessageDelay {
  final int max;
  final int min;
  final int char;
  final int typing;

  MessageDelay({
    required this.max,
    required this.min,
    required this.char,
    required this.typing,
  });

  factory MessageDelay.fromJson(Map<String, dynamic> json) =>
      _$MessageDelayFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDelayToJson(this);
}

@JsonSerializable()
class Logo {
  final String? src;
  final String type;
  Logo({required this.src, required this.type});
  factory Logo.fromJson(Map<String, dynamic> json) => _$LogoFromJson(json);
  Map<String, dynamic> toJson() => _$LogoToJson(this);
}

@JsonSerializable()
class Avatar {
  final String? src;
  final String type;
  Avatar({required this.src, required this.type});
  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}

@JsonSerializable()
class StartPageLinkCard {
  final String id;
  final String url;
  final String icon;
  final String text;
  final String title;
  final String scenario;
  final TimeWindow time_window;

  StartPageLinkCard({
    required this.id,
    required this.url,
    required this.icon,
    required this.text,
    required this.title,
    required this.scenario,
    required this.time_window,
  });
  factory StartPageLinkCard.fromJson(Map<String, dynamic> json) =>
      _$StartPageLinkCardFromJson(json);
  Map<String, dynamic> toJson() => _$StartPageLinkCardToJson(this);
}

@JsonSerializable()
class TimeWindow {
  final String start;
  final String end;

  TimeWindow({required this.start, required this.end});

  factory TimeWindow.fromJson(Map<String, dynamic> json) =>
      _$TimeWindowFromJson(json);

  Map<String, dynamic> toJson() => _$TimeWindowToJson(this);
}
