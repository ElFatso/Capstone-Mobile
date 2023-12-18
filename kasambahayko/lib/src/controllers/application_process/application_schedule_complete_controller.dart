import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/application_schedule_complete_service.dart';

class CompleteInterviewScheduleController extends GetxController {
  final CompleteInterviewScheduleService interviewCompletionService =
      CompleteInterviewScheduleService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> completeInterview(String jobpostId, String applicationId) async {
    try {
      isLoading.value = true;

      final result = await interviewCompletionService.completeInterview(
          jobpostId, applicationId);

      if (result['success']) {
        log('Interview completed successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error completing interview. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
