import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/auth_service/profile_employer_service.dart';

class EmployerProfileController extends GetxController {
  final EmployerProfileService userService = EmployerProfileService();
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  Future<Map<dynamic, dynamic>?> fetchEmployerProfile(String uuid) async {
    try {
      final result = await userService.fetchEmployerProfile(uuid);

      if (result['success']) {
        hasError.value = false;
        errorMessage.value = '';
        log("User Profile Data: ${result['data']}");
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
