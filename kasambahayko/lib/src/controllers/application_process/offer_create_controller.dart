import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/offer_create_service.dart';

class CreateOfferController extends GetxController {
  final CreateOfferService offerService = CreateOfferService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> postOffer(String jobpostId, String applicationId,
      Map<String, dynamic> offer) async {
    try {
      isLoading.value = true;

      final result =
          await offerService.postOffer(jobpostId, applicationId, offer);

      if (result['success']) {
        log('Offer posted successfully!');
      } else {
        error.value = result['error'];
        log('Error posting offer. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
