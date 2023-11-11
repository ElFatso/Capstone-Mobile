import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class ProfileImageUploadService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> uploadProfileImage(
      String uuid, String imagePath) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/profile-img/upload');

    try {
      FormData formData = FormData.fromMap({
        'uuid': uuid,
        'croppedImage':
            await MultipartFile.fromFile(imagePath, filename: 'profile.jpg'),
      });

      final response = await dio.post(
        uri.toString(),
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': response.data};
      } else {
        final Map<String, dynamic> errorData = response.data;
        return {'success': false, 'error': errorData['message']};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
