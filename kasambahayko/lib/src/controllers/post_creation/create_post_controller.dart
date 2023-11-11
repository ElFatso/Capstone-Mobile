import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/post_creation_service/job_post_creation_service.dart';

class CreatePostController extends GetxController {
  String errorMessage = '';

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
    try {
      log('createJobPost called with the following parameters:');
      log('uuid: $uuid');
      log('serviceId: $serviceId');
      log('jobTitle: $jobTitle');
      log('jobDescription: $jobDescription');
      log('jobType: $jobType');
      log('jobStartDate: $jobStartDate');
      log('jobEndDate: $jobEndDate');
      log('jobStartTime: $jobStartTime');
      log('jobEndTime: $jobEndTime');
      log('livingArrangement: $livingArrangement');

      final jobPostService = JobPostCreationService();

      final response = await jobPostService.createJobPost(
        uuid,
        serviceId,
        jobTitle,
        jobDescription,
        jobType,
        jobStartDate,
        jobEndDate,
        jobStartTime,
        jobEndTime,
        livingArrangement,
      );

      log('Response from JobPostCreationService: $response');

      if (response['success']) {
        // Successful job post creation
        final Map<String, dynamic> data = response['data'];
        // Handle the successful response here
        return {'success': true, 'data': data};
      } else {
        // Handle job post creation error
        errorMessage =
            response['error'] ?? 'An error occurred during job post creation.';
        return {'success': false, 'error': errorMessage};
      }
    } catch (error) {
      // Handle network or other errors
      errorMessage = 'An error occurred during the request: $error';
      return {'success': false, 'error': errorMessage};
    }
  }
}
