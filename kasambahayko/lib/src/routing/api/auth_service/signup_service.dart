import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class RegistrationService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> register(
    String firstName,
    String secondName,
    String email,
    String phone,
    String password,
    String userType,
    String city,
    String barangay,
    String street,
  ) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/register');
    try {
      final response = await dio.post(
        uri.toString(),
        data: {
          'firstName': firstName,
          'secondName': secondName,
          'email': email,
          'phone': phone,
          'password': password,
          'user_type': userType,
          'city': city,
          'barangay': barangay,
          'street': street,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': response.data};
      } else {
        final Map<String, dynamic> errorData = response.data;
        return {'success': false, 'error': errorData};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
