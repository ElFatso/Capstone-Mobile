import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/offer_update_service.dart';

class UpdateOfferController extends GetxController {
  final UpdateOfferService updateOfferService = UpdateOfferService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> updateOffer(
    String jobpostId,
    String applicationId,
    Map<String, dynamic> offer,
  ) async {
    try {
      isLoading.value = true;
      final result = await updateOfferService.updateOffer(
        jobpostId,
        applicationId,
        offer,
      );

      if (result['success']) {
        log('Offer updated successfully!');
      } else {
        error.value = result['error'];
        log('Offer update failed. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
