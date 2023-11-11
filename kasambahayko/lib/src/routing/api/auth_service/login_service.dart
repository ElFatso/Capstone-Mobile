import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class LoginService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/auth/login');
    try {
      final response = await dio.post(
        uri.toString(),
        data: {'email': email, 'password': password},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': response.data};
      } else {
        final Map<String, dynamic> errorData = response.data;
        return {'success': false, 'error': errorData['error']};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
