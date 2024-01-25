import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/user_service/worker_profile_service.dart';

class WorkerProfileController extends GetxController {
  final WorkerProfileService workerService = WorkerProfileService();
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  Future<Map<dynamic, dynamic>?> fetchWorkerProfile(String uuid) async {
    try {
      final result = await workerService.fetchWorkerProfile(uuid);

      if (result['success']) {
        hasError.value = false;
        errorMessage.value = '';
        log("Worker Profile Data: ${result['data']}");
      } else {
        hasError.value = true;
        errorMessage.value = result['error'];
        log("Error: ${result['error']}");
      }

      return result['data'];
    } catch (error) {
      hasError.value = true;
      errorMessage.value = 'An error occurred during the request: $error';
      log("Error: $error");
      return null;
    }
  }
}
