class SessionConfiguration {
  String? chatId;

  SessionConfiguration._builder(SessionConfigurationBuilder builder)
      : chatId = builder._chatId;
}

class SessionConfigurationBuilder {
  String? _chatId;

  SessionConfigurationBuilder chatId(String chatId) {
    _chatId = chatId;
    return this;
  }

  SessionConfiguration build() {
    return SessionConfiguration._builder(this);
  }
}
