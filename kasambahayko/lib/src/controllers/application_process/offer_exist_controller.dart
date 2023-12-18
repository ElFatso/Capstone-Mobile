import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/offer_exist_service.dart';

class OfferExistController extends GetxController {
  final OfferExistService offerExistsService = OfferExistService();

  final RxBool isLoading = true.obs;
  final RxMap<String, dynamic> offerData = <String, dynamic>{}.obs;
  final RxString error = ''.obs;

  Future<void> checkOfferExists(String jobpostId) async {
    try {
      isLoading.value = true;
      final result = await offerExistsService.checkOfferExists(jobpostId);

      if (result['success']) {
        final dynamic data = result['data'];

        if (data is Map<String, dynamic>) {
          offerData.assignAll(data);
        } else {}
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
