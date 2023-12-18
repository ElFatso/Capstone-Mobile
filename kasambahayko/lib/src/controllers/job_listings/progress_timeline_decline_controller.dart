import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/job_listings_service/progress_timeline_decline_service.dart';

class DeclineJobOfferController extends GetxController {
  final DeclineJobOfferService declineJobOfferService =
      DeclineJobOfferService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> declineJobOffer(String applicationId) async {
    try {
      isLoading.value = true;

      final result =
          await declineJobOfferService.declineJobOffer(applicationId);

      if (result['success']) {
        log('Job offer declined successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error declining job offer. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
