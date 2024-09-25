import 'dart:typed_data';

import 'package:ebbot_dart_client/util/file.dart';
import 'package:test/test.dart';

// Import your utilities here

void main() {
  group('FileUtils Tests', () {
    test(
        'getFileExtension should return extension from file path if no valid mime type',
        () {
      String filePath = 'image.png';
      Uint8List imageBytes = Uint8List.fromList([]); // Empty list for testing

      String result = getFileExtension(imageBytes, filePath);
      expect(result, equals('png'));
    });

    test('getFileExtension should return extension from MIME type if available',
        () {
      String filePath = 'image.unknown';
      Uint8List imageBytes =
          Uint8List.fromList([0xFF, 0xD8, 0xFF]); // JPEG header

      String result = getFileExtension(imageBytes, filePath);
      expect(result, equals('jpg'));
    });

    test(
        'getFileExtension should return extension from file path if both path extension and MIME type are unavailable',
        () {
      String filePath = 'image.unknown';
      Uint8List imageBytes = Uint8List.fromList([]); // No valid header

      String result = getFileExtension(imageBytes, filePath);
      expect(result, equals('unknown'));
    });

    test('getMimeType should return the correct MIME type for JPEG bytes', () {
      Uint8List imageBytes =
          Uint8List.fromList([0xFF, 0xD8, 0xFF]); // JPEG header

      String result = getMimeType(imageBytes);
      expect(result, equals('image/jpeg'));
    });

    test(
        'getMimeType should return application/octet-stream if bytes are invalid',
        () {
      Uint8List imageBytes = Uint8List.fromList([]); // No valid header

      String result = getMimeType(imageBytes);
      expect(result, equals('application/octet-stream'));
    });

    test('extensionFromMimeType should return correct extension for PNG', () {
      String result = extensionFromMimeType('image/png');
      expect(result, equals('png'));
    });

    test(
        'extensionFromMimeType should return empty string for unknown MIME type',
        () {
      String result = extensionFromMimeType('unknown/mime');
      expect(result, equals(''));
    });
  });
}
