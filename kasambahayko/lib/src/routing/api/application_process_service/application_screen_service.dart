import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class ScreeningResultsService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> updateScreeningResults(
      String jobpostId, List<Map<String, dynamic>> screeningResults) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/employer/post/$jobpostId/screening/results');

    try {
      final response = await dio.post(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'screeningResults': screeningResults},
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Screening results updated'};
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
