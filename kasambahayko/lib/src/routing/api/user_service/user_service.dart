import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class UserService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getUserIdByUuid(String uuid) async {
    final Uri userIdUri =
        Uri.parse('${ApiConstants.baseUrl}/uuid/$uuid/user-id');

    try {
      final response = await dio.get(
        userIdUri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'userId': response.data['userId']};
      } else if (response.statusCode == 404) {
        return {'success': false, 'error': 'User not found'};
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
