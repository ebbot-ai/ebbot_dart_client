import 'package:ebbot_dart_client/valueobjects/environment.dart';

class ConfigResolverService {
  static const Map<Environment, String> baseUrls = {
    Environment.ovhEUProduction:
        'https://storage.gra.cloud.ovh.net/v1/AUTH_fc1ba5ae6eb64e10a8c0b2499d0e8ca9/production/configs/',
    Environment.googleEUProduction:
        'https://ebbot-v2.storage.googleapis.com/configs/',
    Environment.googleCanadaProduction:
        'https://ebbot-ca.storage.googleapis.com/configs/',
    Environment.staging: 'https://storage.gra.cloud.ovh.net/v1/AUTH_8f9eec18dd5a496ea2fae844626938b6/staging/configs'
  };

  // Function to get the appropriate URL based on environment
  static String resolve(Environment environment) {
    final baseUrl = baseUrls[environment];
    if (baseUrl != null) {
      return baseUrl;
    }
    throw Exception("Unknown environment");
  }
}
