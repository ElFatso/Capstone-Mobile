import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/applicants_scheduled_service.dart';

class ScheduledApplicantsController extends GetxController {
  final ScheduledApplicantsService scheduledApplicantsService =
      ScheduledApplicantsService();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> scheduledInterviews =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> completedInterviews =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> allInterviews =
      <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchInterviewSchedules(String jobPostId) async {
    try {
      isLoading.value = true;
      final result =
          await scheduledApplicantsService.getInterviewSchedules(jobPostId);

      if (result['success']) {
        final data = result['data'] as List<dynamic>;
        final mappedData =
            data.map((item) => item as Map<String, dynamic>).toList();

        scheduledInterviews.assignAll(
            mappedData.where((item) => item['status'] == 'scheduled'));
        completedInterviews.assignAll(
            mappedData.where((item) => item['status'] == 'completed'));
        allInterviews.assignAll(mappedData);
        log('scheduledInterviews: $scheduledInterviews');
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
