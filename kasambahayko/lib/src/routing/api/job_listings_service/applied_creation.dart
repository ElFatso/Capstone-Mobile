import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class AppliedJobsCreationService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> applyForJob(String uuid, String jobId) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/worker/application');

    final data = {
      'workerUUID': uuid,
      'jobId': jobId,
    };

    try {
      final response = await dio.post(
        uri.toString(),
        data: data,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message':
              'Application created for ${response.data['data']['user']['first_name']}'
        };
      } else if (response.statusCode == 401) {
        return {'success': false, 'error': 'Invalid UUID'};
      } else {
        return {'success': false, 'error': 'Error creating application'};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
