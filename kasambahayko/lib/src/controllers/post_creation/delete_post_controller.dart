import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/post_creation_service/job_post_deletion_service.dart';

class DeletePostController extends GetxController {
  final JobPostDeletionService jobPostDeletionService =
      JobPostDeletionService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> deleteJobPost(String jobId) async {
    try {
      isLoading.value = true;
      final result = await jobPostDeletionService.deleteJobPost(jobId);

      log('Delete Job Post Result:$result');

      if (result['success']) {
        // Handle the successful deletion, e.g., by updating the UI or displaying a success message.
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
