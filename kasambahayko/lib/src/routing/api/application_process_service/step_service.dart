import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class StepService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getApplicationStage(String jobId) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/employer/post/$jobId/application/current-stage');

    try {
      final response = await dio.get(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = response.data;

        if (responseData is String) {
          // If the response data is a string, wrap it in a map
          return {
            'success': true,
            'data': {'message': responseData}
          };
        } else {
          // If the response data is already a map, use it as is
          return {'success': true, 'data': responseData};
        }
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
