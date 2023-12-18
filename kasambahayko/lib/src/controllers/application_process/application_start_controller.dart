import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/application_start_service.dart';

class StartApplicationController extends GetxController {
  final StartApplicationService jobApplicationService =
      StartApplicationService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> startJobApplication(String jobpostId) async {
    try {
      isLoading.value = true;
      final result = await jobApplicationService.startJobApplication(jobpostId);

      if (result['success']) {
        log('Job application successful!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Job application failed. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
