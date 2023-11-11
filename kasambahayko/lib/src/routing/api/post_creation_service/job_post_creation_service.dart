import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class JobPostCreationService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> createJobPost(
      String uuid,
      String serviceId,
      String jobTitle,
      String jobDescription,
      String jobType,
      String jobStartDate,
      String jobEndDate,
      String jobStartTime,
      String jobEndTime,
      String livingArrangement) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/employer/post/create');

    final data = {
      'uuid': uuid,
      'serviceId': serviceId,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'jobType': jobType,
      'jobStartDate': jobStartDate,
      'jobEndDate': jobEndDate,
      'jobStartTime': jobStartTime,
      'jobEndTime': jobEndTime,
      'livingArrangement': livingArrangement,
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
