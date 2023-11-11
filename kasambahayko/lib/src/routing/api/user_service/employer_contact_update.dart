import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class UserContactInfoService {
  final Dio dio = Dio();

  Future<String> updateUserContactInfo(
      String uuid, String phoneNumber, String email) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/user/update-info');

    try {
      final response = await dio.patch(
        uri.toString(),
        data: {
          'uuid': uuid,
          'phoneNumber': phoneNumber,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return ('Contact information updated!');
      } else {
        throw Exception('Failed to update contact information');
      }
    } catch (error) {
      rethrow;
    }
  }
}
