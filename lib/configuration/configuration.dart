import 'package:ebbot_dart_client/configuration/log_configuration.dart';
import 'package:ebbot_dart_client/configuration/session_configuration.dart';
import 'package:ebbot_dart_client/valueobjects/environment.dart';

class Configuration {
  final Environment
      environment; // This lives in the ebbot_dart_client package for now
  final LogConfiguration logConfiguration;
  final SessionConfiguration sessionConfiguration;

  Configuration._builder(ConfigurationBuilder builder)
      : environment = builder._environment,
        logConfiguration = builder._logConfiguration,
        sessionConfiguration = builder._sessionConfiguration;

  factory Configuration(ConfigurationBuilder builder) {
    return Configuration._builder(builder);
  }
}

class ConfigurationBuilder {
  Environment _environment = Environment.staging; // Default to staging
  LogConfiguration _logConfiguration = LogConfigurationBuilder().build();
  SessionConfiguration _sessionConfiguration =
      SessionConfigurationBuilder().build();

  ConfigurationBuilder environment(Environment env) {
    _environment = env;
    return this;
  }

  ConfigurationBuilder logConfiguration(LogConfiguration logConfiguration) {
    _logConfiguration = logConfiguration;
    return this;
  }

  ConfigurationBuilder sessionConfiguration(
      SessionConfiguration sessionConfiguration) {
    _sessionConfiguration = sessionConfiguration;
    return this;
  }

  Configuration build() {
    return Configuration._builder(this);
  }
}
