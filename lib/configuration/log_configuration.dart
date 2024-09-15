import 'package:logger/logger.dart';

class LogConfiguration {
  bool enabled;
  Level logLevel;

  LogConfiguration._builder(LogConfigurationBuilder builder)
      : enabled = builder._enabled,
        logLevel = builder._logLevel;
}

class LogConfigurationBuilder {
  bool _enabled = false;
  Level _logLevel = Level.trace;

  LogConfigurationBuilder enabled(bool enabled) {
    _enabled = enabled;
    return this;
  }

  LogConfigurationBuilder logLevel(Level logLevel) {
    _logLevel = logLevel;
    return this;
  }

  LogConfiguration build() {
    return LogConfiguration._builder(this);
  }
}
