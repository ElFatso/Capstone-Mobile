import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/application_schedule_revert_service.dart';

class RevertInterviewScheduleController extends GetxController {
  final RevertInterviewScheduleService revertInterviewService =
      RevertInterviewScheduleService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> revertInterviewSchedule(
      String jobpostId, String applicationId) async {
    try {
      isLoading.value = true;

      final result = await revertInterviewService.revertInterviewSchedule(
          jobpostId, applicationId);

      if (result['success']) {
        log('Interview schedule reverted successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error reverting interview schedule. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
