class EnvironmentConfigurationConfig {
  static const String ovhEUProduction =
      'https://storage.gra.cloud.ovh.net/v1/AUTH_fc1ba5ae6eb64e10a8c0b2499d0e8ca9/production/configs/';
  static const String googleEUProduction =
      'https://ebbot-v2.storage.googleapis.com/configs/';
  static const String googleCanadaProduction =
      'https://ebbot-ca.storage.googleapis.com/configs/';

  static const String release =
      'https://ebbot-release.storage.googleapis.com/configs/';
  static const String staging =
      'https://ebbot-staging.storage.googleapis.com/configs/';

  // Function to get the appropriate URL based on environment
  static String getConfigUrl(Environment environment) {
    switch (environment) {
      case Environment.ovhEUProduction:
        return ovhEUProduction;
      case Environment.googleEUProduction:
        return googleEUProduction;
      case Environment.googleCanadaProduction:
        return googleCanadaProduction;
      case Environment.release:
        return release;
      case Environment.staging:
        return staging;
      default:
        throw Exception("Unknown environment");
    }
  }
}

enum Environment {
  ovhEUProduction,
  googleEUProduction,
  googleCanadaProduction,
  release,
  staging
}
