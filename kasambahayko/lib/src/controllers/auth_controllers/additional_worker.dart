import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/auth_service/additional_worker.dart';

class CompleteWorkerProfileController extends GetxController {
  String errorMessage = '';

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
    try {
      log('completeWorkerProfile called with the following parameters:');
      log('uuid: $uuid');
      log('availability: $availability');
      log('bio: $bio');
      log('certifications: $certifications');
      log('education: $education');
      log('hourlyRate: $hourlyRate');
      log('languages: $languages');
      log('skills: $skills');
      log('workExperience: $workExperience');
      log('servicesOffered: $servicesOffered');

      final profileService = CompleteWorkerProfileService();

      final response = await profileService.completeWorkerProfile(
        uuid,
        availability,
        bio,
        certifications,
        education,
        hourlyRate,
        languages,
        skills,
        workExperience,
        servicesOffered,
      );

      log('Response from CompleteWorkerProfileService: $response');

      if (response['success']) {
        // Successful profile completion
        final Map<String, dynamic> data = response['data'];
        // Handle the successful response here
        return {'success': true, 'data': data};
      } else if (response['error'] == 'Invalid UUID') {
        // Handle invalid UUID error
        errorMessage = 'Invalid UUID';
        return {'success': false, 'error': errorMessage};
      } else {
        // Handle profile completion error
        errorMessage = response['error'] ?? 'Error completing worker profile';
        return {'success': false, 'error': errorMessage};
      }
    } catch (error) {
      // Handle network or other errors
      errorMessage = 'An error occurred during the request: $error';
      return {'success': false, 'error': errorMessage};
    }
  }
}
