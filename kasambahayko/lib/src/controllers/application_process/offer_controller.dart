import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/offer_service.dart';

class OfferController extends GetxController {
  final OfferService offerService = OfferService();

  final RxBool isLoading = true.obs;
  final RxMap<String, dynamic> offer = <String, dynamic>{}.obs;
  final RxString error = ''.obs;

  Future<void> fetchOffer(String jobPostId, String applicationId) async {
    try {
      isLoading.value = true;
      log('Fetching offer for jobPostId: $jobPostId, applicationId: $applicationId');

      final result = await offerService.getOffer(jobPostId, applicationId);

      if (result['success']) {
        final data = result['data'];

        if (data != null && data is Map<String, dynamic>) {
          offer.assignAll(data);
          log('Offer fetched successfully: $data');
        } else {
          offer.assignAll({});
        }
      } else {
        error.value = result['error'];
        log('Error fetching offer: ${result['error']}');
      }
    } catch (e, stacktrace) {
      log('Error during offer fetch: $e');
      log('Stacktrace: $stacktrace');
    } finally {
      isLoading.value = false;
      log('Fetch operation completed');
    }
  }
}
