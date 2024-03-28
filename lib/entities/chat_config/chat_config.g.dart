// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatConfig _$ChatConfigFromJson(Map<String, dynamic> json) => ChatConfig(
      version: json['version'] as String,
      scenario: Scenario.fromJson(json['scenario'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatConfigToJson(ChatConfig instance) =>
    <String, dynamic>{
      'version': instance.version,
      'scenario': instance.scenario,
    };

ChatStyle _$ChatStyleFromJson(Map<String, dynamic> json) => ChatStyle(
      version: json['version'] as String,
      v1: ChatStyleV1.fromJson(json['v1'] as Map<String, dynamic>),
      v2: ChatStyleV2.fromJson(json['v2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatStyleToJson(ChatStyle instance) => <String, dynamic>{
      'version': instance.version,
      'v1': instance.v1,
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
      spamTextColor: json['spamTextColor'] as String,
      spamTextBackground: json['spamTextBackground'] as String,
      spamText: json['spamText'] as String,
      headerColor: json['headerColor'] as String,
      headerTextColor: json['headerTextColor'] as String,
      bubbleColor: json['bubbleColor'] as String,
      headerTitle: json['headerTitle'] as String,
      headerText: json['headerText'] as String,
      placeholderText: json['placeholderText'] as String,
      avatar: AvatarStyle.fromJson(json['avatar'] as Map<String, dynamic>),
      logo: LogoStyle.fromJson(json['logo'] as Map<String, dynamic>),
      bubbleIcon:
          BubbleIconStyle.fromJson(json['bubbleIcon'] as Map<String, dynamic>),
      titleFont:
          TitleFontStyle.fromJson(json['titleFont'] as Map<String, dynamic>),
      textFont:
          TextFontStyle.fromJson(json['textFont'] as Map<String, dynamic>),
      globalFont: json['globalFont'] as bool,
      iconPlateColor: json['iconPlateColor'] as String,
      iconIconColor: json['iconIconColor'] as String,
      widgetBorderRadius: json['widgetBorderRadius'] as String,
      btnClickedBackgroundColor: json['btnClickedBackgroundColor'] as String,
      btnClickedTextColor: json['btnClickedTextColor'] as String,
      regularBtnBackgroundColor: json['regularBtnBackgroundColor'] as String,
      regularBtnTextColor: json['regularBtnTextColor'] as String,
      regularBtnBorderRadius: json['regularBtnBorderRadius'] as String,
      sendBtnBackgroundColor: json['sendBtnBackgroundColor'] as String,
      arrowColor: json['arrowColor'] as String,
      qrBackgroundColor: json['qrBackgroundColor'] as String,
      qrTextColor: json['qrTextColor'] as String,
      qrBorderColor: json['qrBorderColor'] as String,
      qrBorderRadius: json['qrBorderRadius'] as String,
      chatBubbleBackgroundColor: json['chatBubbleBackgroundColor'] as String,
      chatBubbleTextColor: json['chatBubbleTextColor'] as String,
      agentChatBubbleBackgroundColor:
          json['agentChatBubbleBackgroundColor'] as String,
      agentChatBubbleTextColor: json['agentChatBubbleTextColor'] as String,
      messageDotsColor: json['messageDotsColor'] as String,
      showBadgeCount: json['showBadgeCount'] as String,
      showTitleCount: json['showTitleCount'] as String,
      signInEnabled: json['signInEnabled'] as bool,
      signInTitle: json['signInTitle'] as String,
      signInText: json['signInText'] as String,
      signInUrl: json['signInUrl'] as String,
      alertEnabled: json['alertEnabled'] as bool,
      alertTimeWindow: AlertTimeWindow.fromJson(
          json['alertTimeWindow'] as Map<String, dynamic>),
      infoSectionEnabled: json['infoSectionEnabled'] as bool,
      infoSectionInConversation: json['infoSectionInConversation'] as bool,
      infoSectionTitle: json['infoSectionTitle'] as String,
      infoSectionText: json['infoSectionText'] as String,
      chatPosition: json['chatPosition'] as String,
      chatPositionVertical: json['chatPositionVertical'] as String,
      chatPositionOffset: json['chatPositionOffset'] as String,
      chatPositionVerticalOffset: json['chatPositionVerticalOffset'] as String,
      chatMobilePosition: json['chatMobilePosition'] as String,
      chatMobilePositionVertical: json['chatMobilePositionVertical'] as String,
      chatMobilePositionOffset: json['chatMobilePositionOffset'] as String,
      chatMobilePositionVerticalOffset:
          json['chatMobilePositionVerticalOffset'] as String,
      chatFixedPosition: json['chatFixedPosition'] as bool,
      chatMobileFixedPosition: json['chatMobileFixedPosition'] as bool,
      autoOpenMobile: json['autoOpenMobile'] as bool,
      hideChat: json['hideChat'] as bool,
      disablePopDesktop: json['disablePopDesktop'] as bool,
      disablePopMobilePortrait: json['disablePopMobilePortrait'] as bool,
      disablePopMobileLandscape: json['disablePopMobileLandscape'] as bool,
      soundBot: json['soundBot'] as bool,
      showAgentTyping: json['showAgentTyping'] as bool,
      agentAvatarOnBubble: json['agentAvatarOnBubble'] as bool,
      clearChatOnTab: json['clearChatOnTab'] as bool,
      agentAvatarOnTop: json['agentAvatarOnTop'] as bool,
      disableCountForBot: json['disableCountForBot'] as bool,
      agentInTranscript: json['agentInTranscript'] as bool,
      botInTranscript: json['botInTranscript'] as bool,
      chatWindowHeight: json['chatWindowHeight'] as String,
      footer: json['footer'] as bool,
      autoOpen: json['autoOpen'] as bool,
      chatLanguage:
          ChatLanguage.fromJson(json['chatLanguage'] as Map<String, dynamic>),
      messageDelay:
          MessageDelay.fromJson(json['messageDelay'] as Map<String, dynamic>),
      agentReadStatus: json['agentReadStatus'] as bool,
      clientReadStatus: json['clientReadStatus'] as bool,
      agentQueueHighlight: json['agentQueueHighlight'] as bool,
      agentChatSound: json['agentChatSound'] as bool,
      soundAgentOnChatPage: json['soundAgentOnChatPage'] as bool,
      attSeekerBackgroundColor: json['attSeekerBackgroundColor'] as String,
      attSeekerBorderColor: json['attSeekerBorderColor'] as String,
      attSeekerIgnoreBtnBackgroundColor:
          json['attSeekerIgnoreBtnBackgroundColor'] as String,
      attSeekerIgnoreBtnBorderColor:
          json['attSeekerIgnoreBtnBorderColor'] as String,
      attSeekerIgnoreBtnBorderRadius:
          json['attSeekerIgnoreBtnBorderRadius'] as String,
      attSeekerIgnoreBtnTextColor:
          json['attSeekerIgnoreBtnTextColor'] as String,
      attSeekerRegularBtnBackgroundColor:
          json['attSeekerRegularBtnBackgroundColor'] as String,
      attSeekerRegularBtnBorderColor:
          json['attSeekerRegularBtnBorderColor'] as String,
      attSeekerRegularBtnBorderRadius:
          json['attSeekerRegularBtnBorderRadius'] as String,
      attSeekerRegularBtnTextColor:
          json['attSeekerRegularBtnTextColor'] as String,
      attSeekerShowAvatar: json['attSeekerShowAvatar'] as bool,
      attSeekerTextColor: json['attSeekerTextColor'] as String,
    );

Map<String, dynamic> _$ChatStyleV2ToJson(ChatStyleV2 instance) =>
    <String, dynamic>{
      'spamTextColor': instance.spamTextColor,
      'spamTextBackground': instance.spamTextBackground,
      'spamText': instance.spamText,
      'headerColor': instance.headerColor,
      'headerTextColor': instance.headerTextColor,
      'bubbleColor': instance.bubbleColor,
      'headerTitle': instance.headerTitle,
      'headerText': instance.headerText,
      'placeholderText': instance.placeholderText,
      'avatar': instance.avatar,
      'logo': instance.logo,
      'bubbleIcon': instance.bubbleIcon,
      'titleFont': instance.titleFont,
      'textFont': instance.textFont,
      'globalFont': instance.globalFont,
      'iconPlateColor': instance.iconPlateColor,
      'iconIconColor': instance.iconIconColor,
      'widgetBorderRadius': instance.widgetBorderRadius,
      'btnClickedBackgroundColor': instance.btnClickedBackgroundColor,
      'btnClickedTextColor': instance.btnClickedTextColor,
      'regularBtnBackgroundColor': instance.regularBtnBackgroundColor,
      'regularBtnTextColor': instance.regularBtnTextColor,
      'regularBtnBorderRadius': instance.regularBtnBorderRadius,
      'sendBtnBackgroundColor': instance.sendBtnBackgroundColor,
      'arrowColor': instance.arrowColor,
      'qrBackgroundColor': instance.qrBackgroundColor,
      'qrTextColor': instance.qrTextColor,
      'qrBorderColor': instance.qrBorderColor,
      'qrBorderRadius': instance.qrBorderRadius,
      'chatBubbleBackgroundColor': instance.chatBubbleBackgroundColor,
      'chatBubbleTextColor': instance.chatBubbleTextColor,
      'agentChatBubbleBackgroundColor': instance.agentChatBubbleBackgroundColor,
      'agentChatBubbleTextColor': instance.agentChatBubbleTextColor,
      'messageDotsColor': instance.messageDotsColor,
      'showBadgeCount': instance.showBadgeCount,
      'showTitleCount': instance.showTitleCount,
      'signInEnabled': instance.signInEnabled,
      'signInTitle': instance.signInTitle,
      'signInText': instance.signInText,
      'signInUrl': instance.signInUrl,
      'alertEnabled': instance.alertEnabled,
      'alertTimeWindow': instance.alertTimeWindow,
      'infoSectionEnabled': instance.infoSectionEnabled,
      'infoSectionInConversation': instance.infoSectionInConversation,
      'infoSectionTitle': instance.infoSectionTitle,
      'infoSectionText': instance.infoSectionText,
      'chatPosition': instance.chatPosition,
      'chatPositionVertical': instance.chatPositionVertical,
      'chatPositionOffset': instance.chatPositionOffset,
      'chatPositionVerticalOffset': instance.chatPositionVerticalOffset,
      'chatMobilePosition': instance.chatMobilePosition,
      'chatMobilePositionVertical': instance.chatMobilePositionVertical,
      'chatMobilePositionOffset': instance.chatMobilePositionOffset,
      'chatMobilePositionVerticalOffset':
          instance.chatMobilePositionVerticalOffset,
      'chatFixedPosition': instance.chatFixedPosition,
      'chatMobileFixedPosition': instance.chatMobileFixedPosition,
      'autoOpenMobile': instance.autoOpenMobile,
      'hideChat': instance.hideChat,
      'disablePopDesktop': instance.disablePopDesktop,
      'disablePopMobilePortrait': instance.disablePopMobilePortrait,
      'disablePopMobileLandscape': instance.disablePopMobileLandscape,
      'soundBot': instance.soundBot,
      'showAgentTyping': instance.showAgentTyping,
      'agentAvatarOnBubble': instance.agentAvatarOnBubble,
      'clearChatOnTab': instance.clearChatOnTab,
      'agentAvatarOnTop': instance.agentAvatarOnTop,
      'disableCountForBot': instance.disableCountForBot,
      'agentInTranscript': instance.agentInTranscript,
      'botInTranscript': instance.botInTranscript,
      'chatWindowHeight': instance.chatWindowHeight,
      'footer': instance.footer,
      'autoOpen': instance.autoOpen,
      'chatLanguage': instance.chatLanguage,
      'messageDelay': instance.messageDelay,
      'agentReadStatus': instance.agentReadStatus,
      'clientReadStatus': instance.clientReadStatus,
      'agentQueueHighlight': instance.agentQueueHighlight,
      'agentChatSound': instance.agentChatSound,
      'soundAgentOnChatPage': instance.soundAgentOnChatPage,
      'attSeekerBackgroundColor': instance.attSeekerBackgroundColor,
      'attSeekerBorderColor': instance.attSeekerBorderColor,
      'attSeekerIgnoreBtnBackgroundColor':
          instance.attSeekerIgnoreBtnBackgroundColor,
      'attSeekerIgnoreBtnBorderColor': instance.attSeekerIgnoreBtnBorderColor,
      'attSeekerIgnoreBtnBorderRadius': instance.attSeekerIgnoreBtnBorderRadius,
      'attSeekerIgnoreBtnTextColor': instance.attSeekerIgnoreBtnTextColor,
      'attSeekerRegularBtnBackgroundColor':
          instance.attSeekerRegularBtnBackgroundColor,
      'attSeekerRegularBtnBorderColor': instance.attSeekerRegularBtnBorderColor,
      'attSeekerRegularBtnBorderRadius':
          instance.attSeekerRegularBtnBorderRadius,
      'attSeekerRegularBtnTextColor': instance.attSeekerRegularBtnTextColor,
      'attSeekerShowAvatar': instance.attSeekerShowAvatar,
      'attSeekerTextColor': instance.attSeekerTextColor,
    };

ChatLanguage _$ChatLanguageFromJson(Map<String, dynamic> json) => ChatLanguage(
      shortName: json['shortName'] as String,
    );

Map<String, dynamic> _$ChatLanguageToJson(ChatLanguage instance) =>
    <String, dynamic>{
      'shortName': instance.shortName,
    };

MessageDelay _$MessageDelayFromJson(Map<String, dynamic> json) => MessageDelay(
      min: json['min'] as int,
      max: json['max'] as int,
      char: json['char'] as int,
      typing: json['typing'] as int,
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
      value: json['value'] as String,
    );

Map<String, dynamic> _$AnswersToJson(Answers instance) => <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
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
