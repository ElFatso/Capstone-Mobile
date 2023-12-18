import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/applicants_passed_service.dart';

class PassedInterviewController extends GetxController {
  final PassedInterviewService interviewService = PassedInterviewService();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> passedInterview =
      <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchPassedInterviews(String jobPostId) async {
    try {
      isLoading.value = true;
      final result = await interviewService.getPassedInterviews(jobPostId);

      if (result['success']) {
        final dynamic data = result['data'];

        if (data is Map<String, dynamic>) {
          passedInterview.assignAll([data]);
        } else {
          passedInterview.assignAll([]);
          log(passedInterview.toString());
        }
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
