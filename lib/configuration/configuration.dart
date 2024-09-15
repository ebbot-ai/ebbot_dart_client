import 'package:ebbot_dart_client/configuration/log_configuration.dart';
import 'package:ebbot_dart_client/valueobjects/environment.dart';

class Configuration {
  final Environment
      environment; // This lives in the ebbot_dart_client package for now
  final LogConfiguration logConfiguration;

  Configuration._builder(ConfigurationBuilder builder)
      : environment = builder._environment,
        logConfiguration = builder._logConfiguration;

  factory Configuration(ConfigurationBuilder builder) {
    return Configuration._builder(builder);
  }
}

class ConfigurationBuilder {
  Environment _environment = Environment.staging; // Default to staging
  LogConfiguration _logConfiguration = LogConfigurationBuilder().build();

  ConfigurationBuilder environment(Environment env) {
    _environment = env;
    return this;
  }

  ConfigurationBuilder logConfiguration(LogConfiguration logConfiguration) {
    _logConfiguration = logConfiguration;
    return this;
  }

  Configuration build() {
    return Configuration._builder(this);
  }
}
