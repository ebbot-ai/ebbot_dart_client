import 'package:ebbot_dart_client/valueobjects/environment.dart';

class AsyngularResolverService {
  static const Map<Environment, String> baseUrls = {
    Environment.ovhEUProduction: 'ebbot.eu',
    Environment.googleEUProduction: 'v2.ebbot.app',
    Environment.googleCanadaProduction: 'ca.ebbot.app',
    Environment.release: 'release.ebbot.app',
    Environment.staging: 'staging.ebbot.eu'
  };

  // resolve the URL
  static String resolve(Environment environment) {
    final baseUrl = baseUrls[environment];
    if (baseUrl != null) {
      return baseUrl;
    }
    throw Exception("Unknown environment");
  }

  // resolve the URL with ws
  static String resolveWs(Environment environment) {
    return 'wss://${resolve(environment)}';
  }

  // resolve the URL with https
  static String resolveHttps(Environment environment) {
    return 'https://${resolve(environment)}';
  }
}
