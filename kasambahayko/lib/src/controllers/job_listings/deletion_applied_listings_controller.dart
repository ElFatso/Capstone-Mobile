import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/job_listings_service/applied_deletion.dart';

class DeleteApplicationController extends GetxController {
  String errorMessage = '';

  Future<Map<String, dynamic>> deleteApplication(
      String uuid, String jobId) async {
    try {
      log('deleteApplication called with the following parameters:');
      log('uuid: $uuid');
      log('jobId: $jobId');

      final deleteApplicationService = DeleteApplicationService();

      final response =
          await deleteApplicationService.deleteApplication(uuid, jobId);

      log('Response from DeleteApplicationService: $response');

      if (response['success']) {
        // Successful job application deletion
        final Map<String, dynamic> data = response['data'];
        // Handle the successful response here
        return {'success': true, 'data': data};
      } else if (response['error'] == 'Invalid UUID') {
        // Handle invalid UUID error
        errorMessage = 'Invalid UUID';
        return {'success': false, 'error': errorMessage};
      } else {
        // Handle job application deletion error
        errorMessage = response['error'] ?? 'Error deleting job application';
        return {'success': false, 'error': errorMessage};
      }
    } catch (error) {
      // Handle network or other errors
      errorMessage = 'An error occurred during the request: $error';
      return {'success': false, 'error': errorMessage};
    }
  }
}
