import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class JobPostModificationService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> updateJobPost(
    String jobId,
    String serviceId,
    String jobTitle,
    String jobDescription,
    String jobStartDate,
    String jobEndDate,
    String jobStartTime,
    String jobEndTime,
    String jobType,
    String livingArrangement,
  ) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/employer/post/update');
    final data = {
      'jobId': jobId,
      'serviceId': serviceId,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'jobStartDate': jobStartDate,
      'jobEndDate': jobEndDate,
      'jobStartTime': jobStartTime,
      'jobEndTime': jobEndTime,
      'jobType': jobType,
      'livingArrangement': livingArrangement,
    };

    try {
      final response = await dio.put(
        uri.toString(),
        data: data,
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
