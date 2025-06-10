import 'dart:io';
import 'package:dio/dio.dart';

Future<String> uploadImageToCloudinary(File imageFile) async {
  String cloudName = 'dzxgs7oxa';
  String uploadPreset = 'unsigned_preset';

  String uploadUrl = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

  try {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path),
      'upload_preset': uploadPreset,
    });

    var response = await Dio().post(uploadUrl, data: formData);

    if (response.statusCode == 200) {
      String imageUrl = response.data['secure_url'];
      print('Image uploaded: $imageUrl');
      return imageUrl;
    } else {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  } catch (e) {
    print('Upload error: $e');
    rethrow;
  }
}
