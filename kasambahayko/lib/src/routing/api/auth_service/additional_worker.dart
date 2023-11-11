import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class CompleteWorkerProfileService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> completeWorkerProfile(
    String uuid,
    String availability,
    String bio,
    List<Map<String, dynamic>> certifications,
    String education,
    double hourlyRate,
    List<Map<String, dynamic>> languages,
    List<String> skills,
    String workExperience,
    List<Map<String, dynamic>> servicesOffered,
  ) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/worker/complete-profile');

    final data = {
      'uuid': uuid,
      'availability': availability,
      'bio': bio,
      'certifications': certifications,
      'education': education,
      'hourlyRate': hourlyRate,
      'languages': languages,
      'skills': skills,
      'workExperience': workExperience,
      'servicesOffered': servicesOffered,
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
              'Worker profile created for ${response.data['user']['first_name']}',
        };
      } else if (response.statusCode == 401) {
        return {'success': false, 'error': 'Invalid UUID'};
      } else {
        return {'success': false, 'error': 'Error creating profile'};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
