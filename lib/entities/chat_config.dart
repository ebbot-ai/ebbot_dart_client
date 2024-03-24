import 'package:json_annotation/json_annotation.dart';

part 'chat_config.g.dart';

@JsonSerializable()
class ChatConfig {
  //@JsonKey(name: 'chat_style')
  //final ChatStyle chatStyle;
  final String version;
  //final BotChatStyles botChatStyles;
  //final Features features;
  //final List<String> CustomCss;
  final Scenario scenario;
  //final List<String> restrictions;
  //final List<ChatTriggers> chatTriggers;

  ChatConfig({
    //equired this.chatStyle,
    required this.version,
    //required this.botChatStyles,
    //required this.features,
    //required this.CustomCss,
    required this.scenario,
    //required this.restrictions,
    //required this.chatTriggers,
  });

  factory ChatConfig.fromJson(Map<String, dynamic> json) =>
      _$ChatConfigFromJson(json);
}

@JsonSerializable()
class ChatStyle {
  final String version;
  final ChatStyleV1 v1;
  final ChatStyleV2 v2;
  
  ChatStyle({
    required this.version,
    required this.v1,
    required this.v2,
  });

  factory ChatStyle.fromJson(Map<String, dynamic> json) =>
      _$ChatStyleFromJson(json);

  Map<String, dynamic> toJson() => _$ChatStyleToJson(this);
}

@JsonSerializable()
class ChatStyleV1 {
  final bool agentAvatarOnBubble;
  final bool agentAvatarOnTop;
  final bool agentInTranscript;
  final bool agentQueueHighlight;
  final bool agentReadStatus;
  final String arrowColor;
  final bool autoOpen;
  final bool autoOpenMobile;
  final bool botInTranscript;
  final bool chatFixedPosition;
  final ChatLanguage chatLanguage;
  final bool chatMobileFixedPosition;
  final String chatMobilePosition;
  final String chatMobilePositionOffset;
  final String chatMobilePositionVertical;
  final String chatMobilePositionVerticalOffset;
  final String chatPosition;
  final String chatPositionOffset;
  final String chatPositionVertical;
  final String chatPositionVerticalOffset;
  final String chatWindowHeight;
  final bool clearChatOnTab;
  final bool clientReadStatus;
  final bool disableCountForBot;
  final bool disablePopDesktop;
  final bool disablePopMobileLandscape;
  final bool disablePopMobilePortrait;
  final bool footer;
  final bool hasArrowColor;
  final bool hideChat;
  final MessageDelay messageDelay;
  final bool showAgentTyping;
  final bool soundBot;

  ChatStyleV1({
    required this.agentAvatarOnBubble,
    required this.agentAvatarOnTop,
    required this.agentInTranscript,
    required this.agentQueueHighlight,
    required this.agentReadStatus,
    required this.arrowColor,
    required this.autoOpen,
    required this.autoOpenMobile,
    required this.botInTranscript,
    required this.chatFixedPosition,
    required this.chatLanguage,
    required this.chatMobileFixedPosition,
    required this.chatMobilePosition,
    required this.chatMobilePositionOffset,
    required this.chatMobilePositionVertical,
    required this.chatMobilePositionVerticalOffset,
    required this.chatPosition,
    required this.chatPositionOffset,
    required this.chatPositionVertical,
    required this.chatPositionVerticalOffset,
    required this.chatWindowHeight,
    required this.clearChatOnTab,
    required this.clientReadStatus,
    required this.disableCountForBot,
    required this.disablePopDesktop,
    required this.disablePopMobileLandscape,
    required this.disablePopMobilePortrait,
    required this.footer,
    required this.hasArrowColor,
    required this.hideChat,
    required this.messageDelay,
    required this.showAgentTyping,
    required this.soundBot,
  });

  factory ChatStyleV1.fromJson(Map<String, dynamic> json) =>
      _$ChatStyleV1FromJson(json);

  Map<String, dynamic> toJson() => _$ChatStyleV1ToJson(this);
}

@JsonSerializable()
class ChatStyleV2 {
  final String spamTextColor;
  final String spamTextBackground;
  final String spamText;
  final String headerColor;
  final String headerTextColor;
  final String bubbleColor;
  final String headerTitle;
  final String headerText;
  final String placeholderText;
  final AvatarStyle avatar;
  final LogoStyle logo;
  final BubbleIconStyle bubbleIcon;
  final TitleFontStyle titleFont;
  final TextFontStyle textFont;
  final bool globalFont;
  final String iconPlateColor;
  final String iconIconColor;
  final String widgetBorderRadius;
  final String btnClickedBackgroundColor;
  final String btnClickedTextColor;
  final String regularBtnBackgroundColor;
  final String regularBtnTextColor;
  final String regularBtnBorderRadius;
  final String sendBtnBackgroundColor;
  final String arrowColor;
  final String qrBackgroundColor;
  final String qrTextColor;
  final String qrBorderColor;
  final String qrBorderRadius;
  final String chatBubbleBackgroundColor;
  final String chatBubbleTextColor;
  final String agentChatBubbleBackgroundColor;
  final String agentChatBubbleTextColor;
  final String messageDotsColor;
  final String showBadgeCount;
  final String showTitleCount;
  final bool signInEnabled;
  final String signInTitle;
  final String signInText;
  final String signInUrl;
  final bool alertEnabled;
  final AlertTimeWindow alertTimeWindow;
  final bool infoSectionEnabled;
  final bool infoSectionInConversation;
  final String infoSectionTitle;
  final String infoSectionText;
  final String chatPosition;
  final String chatPositionVertical;
  final String chatPositionOffset;
  final String chatPositionVerticalOffset;
  final String chatMobilePosition;
  final String chatMobilePositionVertical;
  final String chatMobilePositionOffset;
  final String chatMobilePositionVerticalOffset;
  final bool chatFixedPosition;
  final bool chatMobileFixedPosition;
  final bool autoOpenMobile;
  final bool hideChat;
  final bool disablePopDesktop;
  final bool disablePopMobilePortrait;
  final bool disablePopMobileLandscape;
  final bool soundBot;
  final bool showAgentTyping;
  final bool agentAvatarOnBubble;
  final bool clearChatOnTab;
  final bool agentAvatarOnTop;
  final bool disableCountForBot;
  final bool agentInTranscript;
  final bool botInTranscript;
  final String chatWindowHeight;
  final bool footer;
  final bool autoOpen;
  final ChatLanguage chatLanguage;
  final MessageDelay messageDelay;
  final bool agentReadStatus;
  final bool clientReadStatus;
  final bool agentQueueHighlight;
  final bool agentChatSound;
  final bool soundAgentOnChatPage;
  final String attSeekerBackgroundColor;
  final String attSeekerBorderColor;
  final String attSeekerIgnoreBtnBackgroundColor;
  final String attSeekerIgnoreBtnBorderColor;
  final String attSeekerIgnoreBtnBorderRadius;
  final String attSeekerIgnoreBtnTextColor;
  final String attSeekerRegularBtnBackgroundColor;
  final String attSeekerRegularBtnBorderColor;
  final String attSeekerRegularBtnBorderRadius;
  final String attSeekerRegularBtnTextColor;
  final bool attSeekerShowAvatar;
  final String attSeekerTextColor;

  ChatStyleV2({
    required this.spamTextColor,
    required this.spamTextBackground,
    required this.spamText,
    required this.headerColor,
    required this.headerTextColor,
    required this.bubbleColor,
    required this.headerTitle,
    required this.headerText,
    required this.placeholderText,
    required this.avatar,
    required this.logo,
    required this.bubbleIcon,
    required this.titleFont,
    required this.textFont,
    required this.globalFont,
    required this.iconPlateColor,
    required this.iconIconColor,
    required this.widgetBorderRadius,
    required this.btnClickedBackgroundColor,
    required this.btnClickedTextColor,
    required this.regularBtnBackgroundColor,
    required this.regularBtnTextColor,
    required this.regularBtnBorderRadius,
    required this.sendBtnBackgroundColor,
    required this.arrowColor,
    required this.qrBackgroundColor,
    required this.qrTextColor,
    required this.qrBorderColor,
    required this.qrBorderRadius,
    required this.chatBubbleBackgroundColor,
    required this.chatBubbleTextColor,
    required this.agentChatBubbleBackgroundColor,
    required this.agentChatBubbleTextColor,
    required this.messageDotsColor,
    required this.showBadgeCount,
    required this.showTitleCount,
    required this.signInEnabled,
    required this.signInTitle,
    required this.signInText,
    required this.signInUrl,
    required this.alertEnabled,
    required this.alertTimeWindow,
    required this.infoSectionEnabled,
    required this.infoSectionInConversation,
    required this.infoSectionTitle,
    required this.infoSectionText,
    required this.chatPosition,
    required this.chatPositionVertical,
    required this.chatPositionOffset,
    required this.chatPositionVerticalOffset,
    required this.chatMobilePosition,
    required this.chatMobilePositionVertical,
    required this.chatMobilePositionOffset,
    required this.chatMobilePositionVerticalOffset,
    required this.chatFixedPosition,
    required this.chatMobileFixedPosition,
    required this.autoOpenMobile,
    required this.hideChat,
    required this.disablePopDesktop,
    required this.disablePopMobilePortrait,
    required this.disablePopMobileLandscape,
    required this.soundBot,
    required this.showAgentTyping,
    required this.agentAvatarOnBubble,
    required this.clearChatOnTab,
    required this.agentAvatarOnTop,
    required this.disableCountForBot,
    required this.agentInTranscript,
    required this.botInTranscript,
    required this.chatWindowHeight,
    required this.footer,
    required this.autoOpen,
    required this.chatLanguage,
    required this.messageDelay,
    required this.agentReadStatus,
    required this.clientReadStatus,
    required this.agentQueueHighlight,
    required this.agentChatSound,
    required this.soundAgentOnChatPage,
    required this.attSeekerBackgroundColor,
    required this.attSeekerBorderColor,
    required this.attSeekerIgnoreBtnBackgroundColor,
    required this.attSeekerIgnoreBtnBorderColor,
    required this.attSeekerIgnoreBtnBorderRadius,
    required this.attSeekerIgnoreBtnTextColor,
    required this.attSeekerRegularBtnBackgroundColor,
    required this.attSeekerRegularBtnBorderColor,
    required this.attSeekerRegularBtnBorderRadius,
    required this.attSeekerRegularBtnTextColor,
    required this.attSeekerShowAvatar,
    required this.attSeekerTextColor,
  });

  factory ChatStyleV2.fromJson(Map<String, dynamic> json) =>
      _$ChatStyleV2FromJson(json);

  Map<String, dynamic> toJson() => _$ChatStyleV2ToJson(this);
}

@JsonSerializable()
class ChatLanguage {
  final String shortName;

  ChatLanguage({
    required this.shortName,
  });

  factory ChatLanguage.fromJson(Map<String, dynamic> json) =>
      _$ChatLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatLanguageToJson(this);
}

@JsonSerializable()
class MessageDelay {
  final int min;
  final int max;
  final int char;
  final int typing;

  MessageDelay({
    required this.min,
    required this.max,
    required this.char,
    required this.typing,
  });

  factory MessageDelay.fromJson(Map<String, dynamic> json) =>
      _$MessageDelayFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDelayToJson(this);
}

@JsonSerializable()
class AvatarStyle {
  final String type;

  AvatarStyle({
    required this.type,
  });

  factory AvatarStyle.fromJson(Map<String, dynamic> json) =>
      _$AvatarStyleFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarStyleToJson(this);
}

@JsonSerializable()
class LogoStyle {
  final String type;

  LogoStyle({
    required this.type,
  });

  factory LogoStyle.fromJson(Map<String, dynamic> json) =>
      _$LogoStyleFromJson(json);

  Map<String, dynamic> toJson() => _$LogoStyleToJson(this);
}

@JsonSerializable()
class BubbleIconStyle {
  final String type;

  BubbleIconStyle({
    required this.type,
  });

  factory BubbleIconStyle.fromJson(Map<String, dynamic> json) =>
      _$BubbleIconStyleFromJson(json);

  Map<String, dynamic> toJson() => _$BubbleIconStyleToJson(this);
}

@JsonSerializable()
class TitleFontStyle {
  final String type;

  TitleFontStyle({
    required this.type,
  });

  factory TitleFontStyle.fromJson(Map<String, dynamic> json) =>
      _$TitleFontStyleFromJson(json);

  Map<String, dynamic> toJson() => _$TitleFontStyleToJson(this);
}

@JsonSerializable()
class TextFontStyle {
  final String type;

  TextFontStyle({
    required this.type,
  });

  factory TextFontStyle.fromJson(Map<String, dynamic> json) =>
      _$TextFontStyleFromJson(json);

  Map<String, dynamic> toJson() => _$TextFontStyleToJson(this);
}

@JsonSerializable()
class AlertTimeWindow {
  final String start;
  final String end;

  AlertTimeWindow({
    required this.start,
    required this.end,
  });

  factory AlertTimeWindow.fromJson(Map<String, dynamic> json) =>
      _$AlertTimeWindowFromJson(json);

  Map<String, dynamic> toJson() => _$AlertTimeWindowToJson(this);
}

@JsonSerializable()
class Features {
  final bool trademark;

  Features({
    required this.trademark,
  });

  factory Features.fromJson(Map<String, dynamic> json) =>
      _$FeaturesFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturesToJson(this);
}

@JsonSerializable()
class BotChatStyles {
  final String id;
  final dynamic path; // You can change this type as per your requirement
  final String version;
  final bool isDefault;

  BotChatStyles({
    required this.id,
    required this.path,
    required this.version,
    required this.isDefault,
  });

  factory BotChatStyles.fromJson(Map<String, dynamic> json) =>
      _$BotChatStylesFromJson(json);

  Map<String, dynamic> toJson() => _$BotChatStylesToJson(this);
}

@JsonSerializable()
class Scenario {
  final String id;
  final String name;
  final List<Answers> answers;

  Scenario({
    required this.id,
    required this.name,
    required this.answers,
  });

  factory Scenario.fromJson(Map<String, dynamic> json) =>
      _$ScenarioFromJson(json);

  Map<String, dynamic> toJson() => _$ScenarioToJson(this);
}

@JsonSerializable()
class Answers {
  final String type;
  final String value;

  Answers({
    required this.type,
    required this.value,
  });

  factory Answers.fromJson(Map<String, dynamic> json) =>
      _$AnswersFromJson(json);

  Map<String, dynamic> toJson() => _$AnswersToJson(this);
}

@JsonSerializable()
class ChatTriggers {
  final String id;
  final String companyId;
  final String botId;
  final bool isDefault;
  final bool published;
  final bool disableTriggersAfter;
  final String title;
  final String description;
  final List<When> when;
  final String? should;
  final String triggerScenario;
  final String howOften;
  final String createdAt;
  final String updatedAt;
  final Scenario scenario;

  ChatTriggers({
    required this.id,
    required this.companyId,
    required this.botId,
    required this.isDefault,
    required this.published,
    required this.disableTriggersAfter,
    required this.title,
    required this.description,
    required this.when,
    required this.should,
    required this.triggerScenario,
    required this.howOften,
    required this.createdAt,
    required this.updatedAt,
    required this.scenario,
  });

  factory ChatTriggers.fromJson(Map<String, dynamic> json) =>
      _$ChatTriggersFromJson(json);

  Map<String, dynamic> toJson() => _$ChatTriggersToJson(this);
}

@JsonSerializable()
class When {
  final String type;
  final List<String> values;

  When({
    required this.type,
    required this.values,
  });

  factory When.fromJson(Map<String, dynamic> json) => _$WhenFromJson(json);

  Map<String, dynamic> toJson() => _$WhenToJson(this);
}