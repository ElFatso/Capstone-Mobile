import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class InterviewScheduleService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> scheduleInterview(String jobpostId,
      String applicationId, Map<String, dynamic> interviewResult) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/employer/post/$jobpostId/interview/$applicationId/schedule');

    try {
      final response = await dio.post(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'interviewResult': interviewResult},
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Interview result updated'};
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
