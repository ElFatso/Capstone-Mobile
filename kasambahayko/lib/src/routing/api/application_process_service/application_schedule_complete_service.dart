import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class CompleteInterviewScheduleService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> completeInterview(
      String jobpostId, String applicationId) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/employer/post/$jobpostId/interview/$applicationId/completed');

    try {
      final response = await dio.post(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Interview completed'};
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
