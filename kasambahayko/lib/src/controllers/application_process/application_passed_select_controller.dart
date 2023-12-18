import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/application_passed_select_service.dart';

class SelectPassedController extends GetxController {
  final SelectPassedService passedSelectService = SelectPassedService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> passInterview(String jobpostId, String applicationId) async {
    try {
      isLoading.value = true;

      final result =
          await passedSelectService.passInterview(jobpostId, applicationId);

      if (result['success']) {
        log('Interview passed successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error passing interview. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
