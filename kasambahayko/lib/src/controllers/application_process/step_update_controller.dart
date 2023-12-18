import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/step_update_service.dart';

class UpdateStepController extends GetxController {
  final UpdateStepService applicationStageService = UpdateStepService();

  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> updateApplicationStage(String jobPostId, String stage) async {
    try {
      isLoading.value = true;

      await applicationStageService.updateApplicationStage(jobPostId, stage);

      // Handle success, e.g., show a success message
      log('Application stage updated successfully!');
    } catch (error) {
      // Handle error, e.g., show an error message
      this.error.value = 'Error updating application stage: $error';
      log('Error updating application stage: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
