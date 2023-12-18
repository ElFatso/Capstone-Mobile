import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/job_listings_service/progress_timeline_accept_service.dart';

class AcceptJobOfferController extends GetxController {
  final AcceptJobOfferService acceptJobOfferService = AcceptJobOfferService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> acceptJobOffer(String jobpostId, String applicationId) async {
    try {
      isLoading.value = true;

      final result =
          await acceptJobOfferService.acceptJobOffer(jobpostId, applicationId);

      if (result['success']) {
        log('Job offer accepted successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error accepting job offer. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
