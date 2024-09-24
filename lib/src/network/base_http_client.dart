import 'package:ebbot_dart_client/service/asyngular_resolver_service.dart';
import 'package:ebbot_dart_client/valueobjects/environment.dart';

class BaseHttpClient {
  final Environment _environment;

  Environment get environment => _environment;

  BaseHttpClient(this._environment);

  Uri getAPIUri(String path) {
    final url = AsyngularResolverService.resolveHttps(_environment);
    return Uri.parse("$url/api/$path");
  }

  Uri getWSUri(String path) {
    final url = AsyngularResolverService.resolveWs(_environment);
    return Uri.parse("$url/api/$path");
  }
}
