import 'dart:async';
import 'dart:developer';
import 'package:kasambahayko/src/routing/api/post_creation_service/job_post_modification_service.dart';

class EditPostController {
  final JobPostModificationService service = JobPostModificationService();
  final jobPostModificationState =
      StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get jobPostStream =>
      jobPostModificationState.stream;

  void updateJobPost({
    required String jobId,
    required String serviceId,
    required String jobTitle,
    required String jobDescription,
    required String jobStartDate,
    required String jobEndDate,
    required String jobStartTime,
    required String jobEndTime,
    required String jobType,
    required String livingArrangement,
  }) async {
    try {
      log('updateJobPost called with the following parameters:');
      log('jobId: $jobId');
      log('serviceId: $serviceId');
      log('jobTitle: $jobTitle');
      log('jobDescription: $jobDescription');
      log('jobType: $jobType');
      log('jobStartDate: $jobStartDate');
      log('jobEndDate: $jobEndDate');
      log('jobStartTime: $jobStartTime');
      log('jobEndTime: $jobEndTime');
      log('livingArrangement: $livingArrangement');

      if (jobTitle.isEmpty ||
          jobDescription.isEmpty ||
          jobStartDate.isEmpty ||
          jobEndDate.isEmpty ||
          jobStartTime.isEmpty ||
          jobEndTime.isEmpty ||
          livingArrangement.isEmpty) {
        log('One or more required parameters are empty. Aborting the update.');
        jobPostModificationState.sink.add({
          'success': false,
          'error': 'One or more required parameters are empty.',
        });
        return;
      }

      final result = await service.updateJobPost(
        jobId,
        serviceId,
        jobTitle,
        jobDescription,
        jobStartDate,
        jobEndDate,
        jobStartTime,
        jobEndTime,
        jobType,
        livingArrangement,
      );

      // Log the details of the updated job post
      result.forEach((key, value) {
        log('Job post updated - $key: $value');
      });

      jobPostModificationState.sink.add(result);
    } catch (error) {
      log('Error updating job post: $error');
      jobPostModificationState.sink.add({
        'success': false,
        'error': 'An error occurred: $error',
      });
    }
  }
}
