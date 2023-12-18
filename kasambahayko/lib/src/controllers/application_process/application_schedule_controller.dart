import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/application_schedule_service.dart';

class InterviewScheduleController extends GetxController {
  final InterviewScheduleService interviewScheduleService =
      InterviewScheduleService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> scheduleInterview(String jobpostId, String applicationId,
      Map<String, dynamic> interviewResult) async {
    try {
      isLoading.value = true;

      final result = await interviewScheduleService.scheduleInterview(
          jobpostId, applicationId, interviewResult);

      if (result['success']) {
        log('Interview scheduled successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error scheduling interview. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
