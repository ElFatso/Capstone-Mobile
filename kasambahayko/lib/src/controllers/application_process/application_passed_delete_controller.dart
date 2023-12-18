import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/application_passed_delete_service.dart';

class DeletePassedController extends GetxController {
  final DeletePassedService deletePassedService = DeletePassedService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> deletePassedResult(
      String jobpostId, String applicationId) async {
    try {
      isLoading.value = true;

      final result = await deletePassedService.deletePassedResult(
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
