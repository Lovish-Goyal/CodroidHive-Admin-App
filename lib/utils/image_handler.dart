import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';

class ImageHandler {
  static final _logger = Logger();

  static Future<File?> pickImage(
      {ImageSource source = ImageSource.gallery}) async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image == null) {
        _logger.w('No image selected.');
        return null;
      }

      final file = File(image.path);

      if (!await file.exists()) {
        _logger.e('Selected file does not exist.');
        return null;
      }

      _logger.i('Picked image: ${file.path}');
      return file;
    } catch (e, st) {
      _logger.e('Error picking image', error: e, stackTrace: st);
      return null;
    }
  }

  static Future<String?> uploadImage(File imageFile, String category) async {
    try {
      _logger.i('Uploading image: $imageFile');

      final uri = Uri.parse(
          'https://hiveserver.codroidhub.com/api/api/upload-image-$category');
      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final resStr = await response.stream.bytesToString();
        final decoded = json.decode(resStr);

        final imageUrl = decoded['imageUrl'];
        _logger.i('✅ Uploaded Image URL: $imageUrl');

        return imageUrl;
      } else {
        _logger.e('❌ Failed to upload image. Status: ${response.statusCode}');
        return null;
      }
    } catch (e, st) {
      _logger.e('❌ Exception during image upload', error: e, stackTrace: st);
      return null;
    }
  }
}
