import 'package:ebbot_dart_client/valueobjects/environment.dart';

class Configuration {
  final Environment
      environment; // This lives in the ebbot_dart_client package for now
  final Map<String, dynamic> userAttributes;

  Configuration._builder(ConfigurationBuilder builder)
      : environment = builder._environment,
        userAttributes = builder._userAttributes;

  factory Configuration(ConfigurationBuilder builder) {
    return Configuration._builder(builder);
  }
}

class ConfigurationBuilder {
  Environment _environment = Environment.staging; // Default to staging
  Map<String, dynamic> _userAttributes = {};

  ConfigurationBuilder environment(Environment env) {
    _environment = env;
    return this;
  }

  ConfigurationBuilder userAttributes(Map<String, dynamic> userAttributes) {
    _userAttributes = userAttributes;
    return this;
  }

  Configuration build() {
    return Configuration._builder(this);
  }
}
