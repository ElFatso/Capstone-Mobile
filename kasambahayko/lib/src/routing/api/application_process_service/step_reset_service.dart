import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class ResetStepService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> resetCurrentStage(String jobPostId) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/employer/post/$jobPostId/reset-current-stage');

    try {
      final response = await dio.delete(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Current stage reset'};
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
