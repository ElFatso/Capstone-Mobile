import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/applicant_hiring_service.dart';

class HiredApplicantController extends GetxController {
  final HiredApplicantService hiredApplicantService = HiredApplicantService();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> hiredApplicant =
      <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchHiredApplicant(String jobpostId) async {
    try {
      isLoading.value = true;
      final result = await hiredApplicantService.getHiredApplicant(jobpostId);

      if (result['success']) {
        final dynamic data = result['data'];

        if (data is Map<String, dynamic>) {
          hiredApplicant.assignAll([data]);
        } else {
          hiredApplicant.assignAll([]);
        }
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
