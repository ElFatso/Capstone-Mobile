import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/application_schedule_delete_service.dart';

class DeleteInterviewScheduleController extends GetxController {
  final DeleteInterviewScheduleService interviewScheduleService =
      DeleteInterviewScheduleService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> deleteInterviewResult(
      String jobpostId, String applicationId) async {
    try {
      isLoading.value = true;

      final result = await interviewScheduleService.deleteInterviewResult(
          jobpostId, applicationId);

      if (result['success']) {
        log('Interview result deleted successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error deleting interview result. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
