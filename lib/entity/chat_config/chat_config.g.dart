// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatConfig _$ChatConfigFromJson(Map<String, dynamic> json) => ChatConfig(
      chat_style:
          ChatStyle.fromJson(json['chat_style'] as Map<String, dynamic>),
      version: json['version'] as String,
      scenario: Scenario.fromJson(json['scenario'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatConfigToJson(ChatConfig instance) =>
    <String, dynamic>{
      'chat_style': instance.chat_style,
      'version': instance.version,
      'scenario': instance.scenario,
    };

ChatStyle _$ChatStyleFromJson(Map<String, dynamic> json) => ChatStyle(
      version: json['version'] as String,
      v2: ChatStyleV2.fromJson(json['v2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatStyleToJson(ChatStyle instance) => <String, dynamic>{
      'version': instance.version,
      'v2': instance.v2,
    };

ChatStyleV1 _$ChatStyleV1FromJson(Map<String, dynamic> json) => ChatStyleV1(
      agentAvatarOnBubble: json['agentAvatarOnBubble'] as bool,
      agentAvatarOnTop: json['agentAvatarOnTop'] as bool,
      agentInTranscript: json['agentInTranscript'] as bool,
      agentQueueHighlight: json['agentQueueHighlight'] as bool,
      agentReadStatus: json['agentReadStatus'] as bool,
      arrowColor: json['arrowColor'] as String,
      autoOpen: json['autoOpen'] as bool,
      autoOpenMobile: json['autoOpenMobile'] as bool,
      botInTranscript: json['botInTranscript'] as bool,
      chatFixedPosition: json['chatFixedPosition'] as bool,
      chatLanguage:
          ChatLanguage.fromJson(json['chatLanguage'] as Map<String, dynamic>),
      chatMobileFixedPosition: json['chatMobileFixedPosition'] as bool,
      chatMobilePosition: json['chatMobilePosition'] as String,
      chatMobilePositionOffset: json['chatMobilePositionOffset'] as String,
      chatMobilePositionVertical: json['chatMobilePositionVertical'] as String,
      chatMobilePositionVerticalOffset:
          json['chatMobilePositionVerticalOffset'] as String,
      chatPosition: json['chatPosition'] as String,
      chatPositionOffset: json['chatPositionOffset'] as String,
      chatPositionVertical: json['chatPositionVertical'] as String,
      chatPositionVerticalOffset: json['chatPositionVerticalOffset'] as String,
      chatWindowHeight: json['chatWindowHeight'] as String,
      clearChatOnTab: json['clearChatOnTab'] as bool,
      clientReadStatus: json['clientReadStatus'] as bool,
      disableCountForBot: json['disableCountForBot'] as bool,
      disablePopDesktop: json['disablePopDesktop'] as bool,
      disablePopMobileLandscape: json['disablePopMobileLandscape'] as bool,
      disablePopMobilePortrait: json['disablePopMobilePortrait'] as bool,
      footer: json['footer'] as bool,
      hasArrowColor: json['hasArrowColor'] as bool,
      hideChat: json['hideChat'] as bool,
      messageDelay:
          MessageDelay.fromJson(json['messageDelay'] as Map<String, dynamic>),
      showAgentTyping: json['showAgentTyping'] as bool,
      soundBot: json['soundBot'] as bool,
    );

Map<String, dynamic> _$ChatStyleV1ToJson(ChatStyleV1 instance) =>
    <String, dynamic>{
      'agentAvatarOnBubble': instance.agentAvatarOnBubble,
      'agentAvatarOnTop': instance.agentAvatarOnTop,
      'agentInTranscript': instance.agentInTranscript,
      'agentQueueHighlight': instance.agentQueueHighlight,
      'agentReadStatus': instance.agentReadStatus,
      'arrowColor': instance.arrowColor,
      'autoOpen': instance.autoOpen,
      'autoOpenMobile': instance.autoOpenMobile,
      'botInTranscript': instance.botInTranscript,
      'chatFixedPosition': instance.chatFixedPosition,
      'chatLanguage': instance.chatLanguage,
      'chatMobileFixedPosition': instance.chatMobileFixedPosition,
      'chatMobilePosition': instance.chatMobilePosition,
      'chatMobilePositionOffset': instance.chatMobilePositionOffset,
      'chatMobilePositionVertical': instance.chatMobilePositionVertical,
      'chatMobilePositionVerticalOffset':
          instance.chatMobilePositionVerticalOffset,
      'chatPosition': instance.chatPosition,
      'chatPositionOffset': instance.chatPositionOffset,
      'chatPositionVertical': instance.chatPositionVertical,
      'chatPositionVerticalOffset': instance.chatPositionVerticalOffset,
      'chatWindowHeight': instance.chatWindowHeight,
      'clearChatOnTab': instance.clearChatOnTab,
      'clientReadStatus': instance.clientReadStatus,
      'disableCountForBot': instance.disableCountForBot,
      'disablePopDesktop': instance.disablePopDesktop,
      'disablePopMobileLandscape': instance.disablePopMobileLandscape,
      'disablePopMobilePortrait': instance.disablePopMobilePortrait,
      'footer': instance.footer,
      'hasArrowColor': instance.hasArrowColor,
      'hideChat': instance.hideChat,
      'messageDelay': instance.messageDelay,
      'showAgentTyping': instance.showAgentTyping,
      'soundBot': instance.soundBot,
    };

ChatStyleV2 _$ChatStyleV2FromJson(Map<String, dynamic> json) => ChatStyleV2(
      info_section_enabled: json['info_section_enabled'] as bool,
      info_section_in_conversation:
          json['info_section_in_conversation'] as bool,
      info_section_title: json['info_section_title'] as String,
      info_section_text: json['info_section_text'] as String,
    );

Map<String, dynamic> _$ChatStyleV2ToJson(ChatStyleV2 instance) =>
    <String, dynamic>{
      'info_section_enabled': instance.info_section_enabled,
      'info_section_in_conversation': instance.info_section_in_conversation,
      'info_section_title': instance.info_section_title,
      'info_section_text': instance.info_section_text,
    };

ChatLanguage _$ChatLanguageFromJson(Map<String, dynamic> json) => ChatLanguage(
      shortName: json['shortName'] as String,
    );

Map<String, dynamic> _$ChatLanguageToJson(ChatLanguage instance) =>
    <String, dynamic>{
      'shortName': instance.shortName,
    };

MessageDelay _$MessageDelayFromJson(Map<String, dynamic> json) => MessageDelay(
      min: (json['min'] as num).toInt(),
      max: (json['max'] as num).toInt(),
      char: (json['char'] as num).toInt(),
      typing: (json['typing'] as num).toInt(),
    );

Map<String, dynamic> _$MessageDelayToJson(MessageDelay instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'char': instance.char,
      'typing': instance.typing,
    };

AvatarStyle _$AvatarStyleFromJson(Map<String, dynamic> json) => AvatarStyle(
      type: json['type'] as String,
    );

Map<String, dynamic> _$AvatarStyleToJson(AvatarStyle instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

LogoStyle _$LogoStyleFromJson(Map<String, dynamic> json) => LogoStyle(
      type: json['type'] as String,
    );

Map<String, dynamic> _$LogoStyleToJson(LogoStyle instance) => <String, dynamic>{
      'type': instance.type,
    };

BubbleIconStyle _$BubbleIconStyleFromJson(Map<String, dynamic> json) =>
    BubbleIconStyle(
      type: json['type'] as String,
    );

Map<String, dynamic> _$BubbleIconStyleToJson(BubbleIconStyle instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

TitleFontStyle _$TitleFontStyleFromJson(Map<String, dynamic> json) =>
    TitleFontStyle(
      type: json['type'] as String,
    );

Map<String, dynamic> _$TitleFontStyleToJson(TitleFontStyle instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

TextFontStyle _$TextFontStyleFromJson(Map<String, dynamic> json) =>
    TextFontStyle(
      type: json['type'] as String,
    );

Map<String, dynamic> _$TextFontStyleToJson(TextFontStyle instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

AlertTimeWindow _$AlertTimeWindowFromJson(Map<String, dynamic> json) =>
    AlertTimeWindow(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$AlertTimeWindowToJson(AlertTimeWindow instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

Features _$FeaturesFromJson(Map<String, dynamic> json) => Features(
      trademark: json['trademark'] as bool,
    );

Map<String, dynamic> _$FeaturesToJson(Features instance) => <String, dynamic>{
      'trademark': instance.trademark,
    };

BotChatStyles _$BotChatStylesFromJson(Map<String, dynamic> json) =>
    BotChatStyles(
      id: json['id'] as String,
      path: json['path'],
      version: json['version'] as String,
      isDefault: json['isDefault'] as bool,
    );

Map<String, dynamic> _$BotChatStylesToJson(BotChatStyles instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'version': instance.version,
      'isDefault': instance.isDefault,
    };

Scenario _$ScenarioFromJson(Map<String, dynamic> json) => Scenario(
      id: json['id'] as String,
      name: json['name'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answers.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScenarioToJson(Scenario instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'answers': instance.answers,
    };

Answers _$AnswersFromJson(Map<String, dynamic> json) => Answers(
      type: json['type'] as String,
      value: json['value'],
      input_field: json['input_field'] as String?,
    );

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'input_field': instance.input_field,
    };

ChatTriggers _$ChatTriggersFromJson(Map<String, dynamic> json) => ChatTriggers(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      botId: json['botId'] as String,
      isDefault: json['isDefault'] as bool,
      published: json['published'] as bool,
      disableTriggersAfter: json['disableTriggersAfter'] as bool,
      title: json['title'] as String,
      description: json['description'] as String,
      when: (json['when'] as List<dynamic>)
          .map((e) => When.fromJson(e as Map<String, dynamic>))
          .toList(),
      should: json['should'] as String?,
      triggerScenario: json['triggerScenario'] as String,
      howOften: json['howOften'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      scenario: Scenario.fromJson(json['scenario'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatTriggersToJson(ChatTriggers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'botId': instance.botId,
      'isDefault': instance.isDefault,
      'published': instance.published,
      'disableTriggersAfter': instance.disableTriggersAfter,
      'title': instance.title,
      'description': instance.description,
      'when': instance.when,
      'should': instance.should,
      'triggerScenario': instance.triggerScenario,
      'howOften': instance.howOften,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'scenario': instance.scenario,
    };

When _$WhenFromJson(Map<String, dynamic> json) => When(
      type: json['type'] as String,
      values:
          (json['values'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WhenToJson(When instance) => <String, dynamic>{
      'type': instance.type,
      'values': instance.values,
    };
