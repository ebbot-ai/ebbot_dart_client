class EnvironmentConfigurationConfig {
  static const Map<Environment, String> baseUrls = {
    Environment.ovhEUProduction:
        'https://storage.gra.cloud.ovh.net/v1/AUTH_fc1ba5ae6eb64e10a8c0b2499d0e8ca9/production/configs/',
    Environment.googleEUProduction:
        'https://ebbot-v2.storage.googleapis.com/configs/',
    Environment.googleCanadaProduction:
        'https://ebbot-ca.storage.googleapis.com/configs/',
    Environment.release:
        'https://ebbot-release.storage.googleapis.com/configs/',
    Environment.staging: 'https://ebbot-staging.storage.googleapis.com/configs/'
  };

  // Function to get the appropriate URL based on environment
  static String getConfigUrl(Environment environment) {
    final baseUrl = baseUrls[environment];
    if (baseUrl != null) {
      return baseUrl;
    }
    throw Exception("Unknown environment");
  }
}

enum Environment {
  ovhEUProduction,
  googleEUProduction,
  googleCanadaProduction,
  release,
  staging
}
