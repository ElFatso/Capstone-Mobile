import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/job_listings_service/applied_creation.dart';

class ApplyJobController extends GetxController {
  String errorMessage = '';

  Future<Map<String, dynamic>> applyForJob(
      String workerUUID, String jobId) async {
    try {
      log('applyForJob called with the following parameters:');
      log('uuid: $workerUUID');
      log('jobId: $jobId');

      final jobApplicationService = AppliedJobsCreationService();

      final response =
          await jobApplicationService.applyForJob(workerUUID, jobId);

      log('Response from AppliedJobsCreationService: $response');

      if (response['success']) {
        // Successful job application
        final Map<String, dynamic> data = response['data'];
        // Handle the successful response here
        return {'success': true, 'data': data};
      } else if (response['error'] == 'Invalid UUID') {
        // Handle invalid UUID error
        errorMessage = 'Invalid UUID';
        return {'success': false, 'error': errorMessage};
      } else {
        // Handle job application error
        errorMessage = response['error'] ?? 'Error creating job application';
        return {'success': false, 'error': errorMessage};
      }
    } catch (error) {
      // Handle network or other errors
      errorMessage = 'An error occurred during the request: $error';
      return {'success': false, 'error': errorMessage};
    }
  }
}
