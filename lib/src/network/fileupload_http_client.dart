import 'dart:convert';
import 'dart:typed_data';

import 'package:ebbot_dart_client/entity/fileupload/image.dart';
import 'package:ebbot_dart_client/entity/fileupload/image_response.dart';
import 'package:ebbot_dart_client/entity/fileupload/presign_url.dart';
import 'package:ebbot_dart_client/service/log_service.dart';
import 'package:ebbot_dart_client/src/network/base_http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:ebbot_dart_client/util/file.dart';
import 'package:uuid/uuid.dart';

class FileUploadHttpClient extends BaseHttpClient {
  final Map<String, String> ebbotAPIHeaders = {
    'Accept': 'application/json',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'application/json',
  };

  final logger = GetIt.instance<LogService>().logger;

  late String? token; // Very hacky, should DI this somehow

  FileUploadHttpClient(super.environment);

  Future<ImageResponse> uploadImage(
      Uint8List imageBytes, String filePath) async {
    final filename = _generateFilename(imageBytes, filePath);

    logger?.i('Fetching pre-signed URL for file path $filePath');
    final presignedUrl = await _fetchPreSignedUrl(imageBytes, filename);
    logger?.i('Uploading image to ${presignedUrl.data}');
    final image = await _uploadImage(imageBytes, filename, presignedUrl.data);

    return ImageResponse(
        filename: filename,
        image: image,
        mimeType: getMimeType(imageBytes),
        size: imageBytes.length);
  }

  String _generateFilename(Uint8List imageBytes, String filePath) {
    final uuid = const Uuid().v4();
    final extension = getFileExtension(imageBytes, filePath);
    return '$uuid.$extension';
  }

  Future<Image> _uploadImage(
      Uint8List imageBytes, String filename, String presignedPath) async {
    final uri = Uri.parse(presignedPath);

    var request = http.MultipartRequest('POST', uri);
    request.headers.addAll(ebbotAPIHeaders);
    request.headers['Authorization'] = token!;

    // Determine the file extension;
    logger?.i('Uploading image with filename $filename');
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: filename,
        contentType: MediaType.parse(getMimeType(imageBytes)),
      ),
    );

    var response = await request.send();

    if (response.statusCode >= 400) {
      logger?.e(
          'Failed to upload image with status code ${response.statusCode} and reason ${response.reasonPhrase} and body ${await response.stream.bytesToString()}');
      throw Exception('Failed to upload image');
    }

    final body = await response.stream.bytesToString();

    logger?.i(
        'Image uploaded successfully for url $presignedPath, got status code ${response.statusCode} and reason ${response.reasonPhrase} and body:');
    logger?.i(body);
    return Image.fromJson(json.decode(body));
  }

  Future<PresignUrl> _fetchPreSignedUrl(
      Uint8List imageBytes, String filename) async {
    if (token == null) {
      throw Exception('Token is unexpectedly null, did web_init call fail?');
    }

    final uri = getAPIUri("files/presign-url");
    final mimeType = lookupMimeType('', headerBytes: imageBytes);

    var request = http.Request('POST', uri);

    request.headers.addAll(ebbotAPIHeaders);
    request.headers['Authorization'] = token!;

    request.body = jsonEncode({
      'mimetype': mimeType,
      'filename': filename,
    });
    logger?.i('Fetching pre-signed URL: $uri with body ${request.body}');
    var response = await request.send();

    if (response.statusCode >= 400) {
      logger?.e(
          'Failed to fetch pre-signed URL: ${response.reasonPhrase}, ${response.statusCode}, body string: ${await response.stream.bytesToString()}');
      throw Exception('Failed to fetch pre-signed URL');
    }

    final String body = await response.stream.bytesToString();

    logger?.i(
        'Pre-signed URL fetched successfully: status code ${response.statusCode}');
    logger?.i(body);
    return PresignUrl.fromJson(json.decode(body));
  }

}
