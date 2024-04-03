import 'package:ebbot_dart_client/configuration/environment_configuration_config.dart';
import 'package:ebbot_dart_client/src/network/ebbot_http_client.dart';
import 'package:ebbot_dart_client/entities/chat_config/chat_config.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as Http;

class MockHttpClient extends Mock implements Http.Client {}

void main() {
  group('EbbotHttpClient', () {
    late EbbotHttpClient httpClient;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      httpClient = EbbotHttpClient(
          botId: 'testBotId', chatId: 'testChatId', httpClient: mockHttpClient);
    });

    test('fetchConfig returns ChatConfig for valid environment', () async {
      // Mock the HTTP response for a successful request

      
      final config = httpClient.fetchConfig(Environment.ovhEUProduction);

      httpClient._fetchConfig = (env) async {
        return ChatConfig.fromJson({'test_key': 'test_value'});
      };

      final config = await httpClient.fetchConfig(Environment.ovhEUProduction);

      expect(config, isNotNull);
      // You can add more assertions based on the expected ChatConfig values
    });

    test('fetchConfig throws exception for invalid environment', () async {
      // Mock the HTTP response for a failed request
      httpClient._fetchConfig = (env) async {
        return null;
      };

      expect(
        () async => await httpClient.fetchConfig(Environment.ovhEUProduction),
        throwsA(isA<Exception>()),
      );
    });

    test('fetchConfig returns ChatConfig using fallback', () async {
      // Mock the HTTP response for the first call to fail and subsequent calls to succeed
      bool firstCall = true;
      httpClient._fetchConfig = (env) async {
        if (firstCall) {
          firstCall = false;
          return null;
        } else {
          return ChatConfig.fromJson({'test_key': 'test_value'});
        }
      };

      final config = await httpClient.fetchConfig(Environment.ovhEUProduction);

      expect(config, isNotNull);
      // You can add more assertions based on the expected ChatConfig values
    });
  });
}
