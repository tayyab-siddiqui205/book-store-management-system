import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class CloudinaryService {
  static const String cloudName = "dkcchjxhj";

  static const String uploadPreset = "tayyab";

  Future<String> uploadImage({
    required Uint8List imageBytes,
    required String fileName,
  }) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse(
        "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      ),
    );

    request.fields["upload_preset"] = uploadPreset;

    request.files.add(
      http.MultipartFile.fromBytes(
        "file",
        imageBytes,
        filename: fileName,
      ),
    );

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception("Image upload failed");
    }

    final data = jsonDecode(
      await response.stream.bytesToString(),
    );

    return data["secure_url"];
  }
}