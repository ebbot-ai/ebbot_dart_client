import 'package:ebbot_dart_client/configuration/configuration.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class LogService {
  final _configuration = GetIt.instance<Configuration>();
  final _logger = Logger(
    printer: PrettyPrinter(),
  );

  LogService() {
    Logger.level = _configuration.logConfiguration.logLevel;
  }

  Logger? get logger =>
      _configuration.logConfiguration.enabled ? _logger : null;
}
