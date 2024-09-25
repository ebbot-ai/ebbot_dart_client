import 'package:ebbot_dart_client/entity/fileupload/image.dart';

class ImageResponse {
  final Image image;
  final String mimeType;
  final String filename;
  final int size;

  ImageResponse({
    required this.image,
    required this.mimeType,
    required this.filename,
    required this.size,
  });
}
