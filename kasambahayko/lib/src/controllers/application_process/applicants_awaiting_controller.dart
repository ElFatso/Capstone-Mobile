import 'package:get/get.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_controller.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/applicants_awaiting_service.dart';

class AwaitingApplicantsController extends GetxController {
  final AwaitingApplicantsService qualifiedApplicantsService =
      AwaitingApplicantsService();
  final jobApplicantsController = Get.find<JobApplicantsController>();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> screeningResults =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> screeningPassed =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> screeningFailed =
      <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchScreeningResults(String jobPostId) async {
    try {
      isLoading.value = true;
      final result =
          await qualifiedApplicantsService.getScreeningResults(jobPostId);

      if (result['success']) {
        final data = result['data'] as List<dynamic>;
        final mappedData =
            data.map((item) => item as Map<String, dynamic>).toList();

        screeningPassed
            .assignAll(mappedData.where((item) => item['result'] == 'passed'));
        screeningFailed
            .assignAll(mappedData.where((item) => item['result'] == 'failed'));
        screeningResults.assignAll(mappedData);
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
