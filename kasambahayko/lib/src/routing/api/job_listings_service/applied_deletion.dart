import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class DeleteApplicationService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> deleteApplication(
      String uuid, String jobId) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}/worker/application/$uuid/$jobId');

    try {
      final response = await dio.delete(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message':
              'Application deleted for ${response.data['data']['user']['first_name']}',
        };
      } else if (response.statusCode == 401) {
        return {'success': false, 'error': 'Invalid UUID'};
      } else {
        return {'success': false, 'error': 'Error deleting application'};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
