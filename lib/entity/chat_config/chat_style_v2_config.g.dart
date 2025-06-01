// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_style_v2_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatStyleConfigV2 _$ChatStyleConfigV2FromJson(Map<String, dynamic> json) =>
    ChatStyleConfigV2(
      logo: Logo.fromJson(json['logo'] as Map<String, dynamic>),
      avatar: Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      footer: json['footer'] as bool,
      auto_open: json['auto_open'] as bool,
      hide_chat: json['hide_chat'] as bool,
      sound_bot: json['sound_bot'] as bool,
      spam_text: json['spam_text'] as String,
      text_font: FontType.fromJson(json['text_font'] as Map<String, dynamic>),
      title_font: FontType.fromJson(json['title_font'] as Map<String, dynamic>),
      arrow_color: json['arrow_color'] as String,
      blobCTAText: json['blobCTAText'] as String?,
      bubble_icon:
          BubbleIcon.fromJson(json['bubble_icon'] as Map<String, dynamic>),
      global_font: json['global_font'] as bool,
      header_text: json['header_text'] as String,
      sign_in_url: json['sign_in_url'] as String,
      bubble_color: json['bubble_color'] as String,
      header_color: json['header_color'] as String,
      header_title: json['header_title'] as String,
      logo_enabled: json['logo_enabled'] as bool?,
      sign_in_text: json['sign_in_text'] as String,
      alert_enabled: json['alert_enabled'] as bool,
      chat_language:
          ChatLanguage.fromJson(json['chat_language'] as Map<String, dynamic>),
      chat_position: json['chat_position'] as String,
      message_delay:
          MessageDelay.fromJson(json['message_delay'] as Map<String, dynamic>),
      positionFixed: json['positionFixed'] as bool,
      placeholder_text: json['placeholder_text'] as String,
      auto_open_mobile: json['auto_open_mobile'] as bool,
      sign_in_enabled: json['sign_in_enabled'] as bool,
      agent_chat_sound: json['agent_chat_sound'] as bool,
      show_agent_typing: json['show_agent_typing'] as bool,
      chat_window_height: json['chat_window_height'] as String,
      client_read_status: json['client_read_status'] as bool,
      agent_in_transcript: json['agent_in_transcript'] as bool,
      chat_fixed_position: json['chat_fixed_position'] as bool,
      chat_mobile_position: json['chat_mobile_position'] as String,
      chat_position_offset: json['chat_position_offset'] as String,
      info_section_enabled: json['info_section_enabled'] as bool,
      info_section_title: json['info_section_title'] as String,
      info_section_text: json['info_section_text'] as String,
      info_section_in_conversation:
          json['info_section_in_conversation'] as bool,
      start_page_footer: json['start_page_footer'] as String?,
      avatar_enabled: json['avatar_enabled'] as bool?,
      start_page_enabled: json['start_page_enabled'] as bool?,
      regular_btn_background_color:
          json['regular_btn_background_color'] as String,
      regular_btn_text_color: json['regular_btn_text_color'] as String,
      start_page_link_cards: (json['start_page_link_cards'] as List<dynamic>)
          .map((e) => StartPageLinkCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      icon_plate_color: json['icon_plate_color'] as String,
      icon_icon_color: json['icon_icon_color'] as String,
      alert_time_window: json['alert_time_window'] == null
          ? null
          : TimeWindow.fromJson(
              json['alert_time_window'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatStyleConfigV2ToJson(ChatStyleConfigV2 instance) =>
    <String, dynamic>{
      'logo': instance.logo.toJson(),
      'avatar': instance.avatar.toJson(),
      'footer': instance.footer,
      'auto_open': instance.auto_open,
      'hide_chat': instance.hide_chat,
      'sound_bot': instance.sound_bot,
      'spam_text': instance.spam_text,
      'text_font': instance.text_font.toJson(),
      'title_font': instance.title_font.toJson(),
      'arrow_color': instance.arrow_color,
      'blobCTAText': instance.blobCTAText,
      'bubble_icon': instance.bubble_icon.toJson(),
      'global_font': instance.global_font,
      'header_text': instance.header_text,
      'sign_in_url': instance.sign_in_url,
      'bubble_color': instance.bubble_color,
      'header_color': instance.header_color,
      'header_title': instance.header_title,
      'logo_enabled': instance.logo_enabled,
      'sign_in_text': instance.sign_in_text,
      'alert_enabled': instance.alert_enabled,
      'chat_language': instance.chat_language.toJson(),
      'chat_position': instance.chat_position,
      'message_delay': instance.message_delay.toJson(),
      'positionFixed': instance.positionFixed,
      'placeholder_text': instance.placeholder_text,
      'auto_open_mobile': instance.auto_open_mobile,
      'sign_in_enabled': instance.sign_in_enabled,
      'agent_chat_sound': instance.agent_chat_sound,
      'show_agent_typing': instance.show_agent_typing,
      'chat_window_height': instance.chat_window_height,
      'client_read_status': instance.client_read_status,
      'agent_in_transcript': instance.agent_in_transcript,
      'chat_fixed_position': instance.chat_fixed_position,
      'chat_mobile_position': instance.chat_mobile_position,
      'chat_position_offset': instance.chat_position_offset,
      'info_section_enabled': instance.info_section_enabled,
      'info_section_title': instance.info_section_title,
      'info_section_text': instance.info_section_text,
      'info_section_in_conversation': instance.info_section_in_conversation,
      'regular_btn_background_color': instance.regular_btn_background_color,
      'regular_btn_text_color': instance.regular_btn_text_color,
      'start_page_footer': instance.start_page_footer,
      'avatar_enabled': instance.avatar_enabled,
      'start_page_enabled': instance.start_page_enabled,
      'start_page_link_cards':
          instance.start_page_link_cards.map((e) => e.toJson()).toList(),
      'icon_plate_color': instance.icon_plate_color,
      'icon_icon_color': instance.icon_icon_color,
      'alert_time_window': instance.alert_time_window?.toJson(),
    };

FontType _$FontTypeFromJson(Map<String, dynamic> json) => FontType(
      type: json['type'] as String,
    );

Map<String, dynamic> _$FontTypeToJson(FontType instance) => <String, dynamic>{
      'type': instance.type,
    };

BubbleIcon _$BubbleIconFromJson(Map<String, dynamic> json) => BubbleIcon(
      type: json['type'] as String,
    );

Map<String, dynamic> _$BubbleIconToJson(BubbleIcon instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

ChatLanguage _$ChatLanguageFromJson(Map<String, dynamic> json) => ChatLanguage(
      name: json['name'] as String,
      short_name: json['short_name'] as String,
    );

Map<String, dynamic> _$ChatLanguageToJson(ChatLanguage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'short_name': instance.short_name,
    };

MessageDelay _$MessageDelayFromJson(Map<String, dynamic> json) => MessageDelay(
      max: (json['max'] as num).toInt(),
      min: (json['min'] as num).toInt(),
      char: (json['char'] as num).toInt(),
      typing: (json['typing'] as num).toInt(),
    );

Map<String, dynamic> _$MessageDelayToJson(MessageDelay instance) =>
    <String, dynamic>{
      'max': instance.max,
      'min': instance.min,
      'char': instance.char,
      'typing': instance.typing,
    };

Logo _$LogoFromJson(Map<String, dynamic> json) => Logo(
      src: json['src'] as String?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$LogoToJson(Logo instance) => <String, dynamic>{
      'src': instance.src,
      'type': instance.type,
    };

Avatar _$AvatarFromJson(Map<String, dynamic> json) => Avatar(
      src: json['src'] as String?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'src': instance.src,
      'type': instance.type,
    };

StartPageLinkCard _$StartPageLinkCardFromJson(Map<String, dynamic> json) =>
    StartPageLinkCard(
      id: json['id'] as String,
      url: json['url'] as String,
      icon: json['icon'] as String,
      text: json['text'] as String,
      title: json['title'] as String,
      scenario: json['scenario'] as String,
      time_window:
          TimeWindow.fromJson(json['time_window'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StartPageLinkCardToJson(StartPageLinkCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'icon': instance.icon,
      'text': instance.text,
      'title': instance.title,
      'scenario': instance.scenario,
      'time_window': instance.time_window,
    };

TimeWindow _$TimeWindowFromJson(Map<String, dynamic> json) => TimeWindow(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$TimeWindowToJson(TimeWindow instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };
