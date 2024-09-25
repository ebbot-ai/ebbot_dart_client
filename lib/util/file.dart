import 'dart:typed_data';

import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

String getFileExtension(Uint8List imageBytes, String filePath) {
  // Get extension from file path
  String extension = p.extension(filePath).replaceFirst('.', '');

  // Get MIME type and extension from image bytes
  String? mimeType = lookupMimeType('', headerBytes: imageBytes);
  String extensionFromMime = extensionFromMimeType(mimeType ?? '');

  // Decide which extension to use
  if (extensionFromMime.isNotEmpty) {
    return extensionFromMime;
  } else if (extension.isNotEmpty) {
    return extension;
  } else {
    return 'jpg'; // Default extension
  }
}

String getMimeType(Uint8List imageBytes) {
  String? mimeType = lookupMimeType('', headerBytes: imageBytes);
  return mimeType ?? 'application/octet-stream';
}

String extensionFromMimeType(String mimeType) {
  switch (mimeType) {
    case 'image/jpeg':
      return 'jpg';
    case 'image/png':
      return 'png';
    case 'image/gif':
      return 'gif';
    case 'image/bmp':
      return 'bmp';
    case 'image/tiff':
      return 'tiff';
    default:
      return '';
  }
}
