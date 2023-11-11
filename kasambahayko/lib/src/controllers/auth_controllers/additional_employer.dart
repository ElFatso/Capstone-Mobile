import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/auth_service/additional_employer.dart';

class CompleteEmployerProfileController extends GetxController {
  String errorMessage = '';

  Future<Map<String, dynamic>> completeEmployerProfile(
    String uuid,
    String householdSize,
    Map<String, dynamic> pets,
    String specificNeeds,
    List<Map<String, dynamic>> paymentMethods,
    String paymentFrequency,
    String bio,
  ) async {
    try {
      log('completeEmployerProfile called with the following parameters:');
      log('uuid: $uuid');
      log('householdSize: $householdSize');
      log('pets: $pets');
      log('specificNeeds: $specificNeeds');
      log('paymentMethods: $paymentMethods');
      log('paymentFrequency: $paymentFrequency');
      log('bio: $bio');

      final profileService = CompleteEmployerProfileService();

      final response = await profileService.completeEmployerProfile(
        uuid,
        householdSize,
        pets,
        specificNeeds,
        paymentMethods,
        paymentFrequency,
        bio,
      );

      log('Response from CompleteEmployerProfileService: $response');

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
        errorMessage = response['error'] ?? 'Error completing employer profile';
        return {'success': false, 'error': errorMessage};
      }
    } catch (error) {
      // Handle network or other errors
      errorMessage = 'An error occurred during the request: $error';
      return {'success': false, 'error': errorMessage};
    }
  }
}
