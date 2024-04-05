import 'package:ebbot_dart_client/valueobjects/environment.dart';

class Configuration {
  final Environment
      environment; // This lives in the ebbot_dart_client package for now

  Configuration._builder(ConfigurationBuilder builder)
      : environment = builder._environment;

  factory Configuration(ConfigurationBuilder builder) {
    return Configuration._builder(builder);
  }
}

class ConfigurationBuilder {
  Environment _environment = Environment.staging; // Default to staging

  ConfigurationBuilder environment(Environment env) {
    _environment = env;
    return this;
  }

  Configuration build() {
    return Configuration._builder(this);
  }
}
