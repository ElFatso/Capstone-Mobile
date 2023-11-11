import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class CompleteEmployerProfileService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> completeEmployerProfile(
    String uuid,
    String householdSize,
    Map<String, dynamic> pets,
    String specificNeeds,
    List<Map<String, dynamic>> paymentMethods,
    String paymentFrequency,
    String bio,
  ) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/employer/complete-profile');

    final data = {
      'uuid': uuid,
      'householdSize': householdSize,
      'pets': pets,
      'specificNeeds': specificNeeds,
      'paymentMethods': paymentMethods,
      'paymentFrequency': paymentFrequency,
      'bio': bio,
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
              'Profile completed for ${response.data['user']['first_name']}'
        };
      } else if (response.statusCode == 401) {
        return {'success': false, 'error': 'Invalid UUID'};
      } else {
        return {'success': false, 'error': 'Error completing profile'};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
