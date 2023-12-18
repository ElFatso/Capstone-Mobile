import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class CreateTimelineEventService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> postTimelineEvent(
    String applicationId,
    Map<String, dynamic> timelineEvent,
  ) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/employer/offer/$applicationId/timeline-event');

    try {
      final response = await dio.post(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'timelineEvent': timelineEvent},
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Timeline event added'};
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
