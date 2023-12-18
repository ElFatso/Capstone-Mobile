import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/step_reset_service.dart';

class ResetStepController extends GetxController {
  final ResetStepService resetStepService = ResetStepService();

  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> resetCurrentStage(String jobPostId) async {
    try {
      isLoading.value = true;

      final result = await resetStepService.resetCurrentStage(jobPostId);

      if (result['success']) {
        // Handle success, e.g., show a success message
        log('Current stage reset successfully!');
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error resetting current stage. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
