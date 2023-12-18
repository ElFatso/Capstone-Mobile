import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/application_screen_service.dart';

class ScreeningResultsController extends GetxController {
  final ScreeningResultsService screeningResultsService =
      ScreeningResultsService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> updateScreeningResults(
      String jobpostId, List<Map<String, dynamic>> screeningResults) async {
    try {
      isLoading.value = true;
      final result = await screeningResultsService.updateScreeningResults(
          jobpostId, screeningResults);

      if (result['success']) {
        log('Screening results updated successfully!');
      } else {
        error.value = result['error'];
        log('Error updating screening results. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
