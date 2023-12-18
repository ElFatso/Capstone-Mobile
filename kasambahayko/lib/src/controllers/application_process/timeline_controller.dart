import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/timeline_service.dart';

class TimelineEventController extends GetxController {
  final TimelineEventsService timelineEventsService = TimelineEventsService();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> timelineEvents =
      <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchTimelineEvents(String offerId) async {
    try {
      isLoading.value = true;
      log('Fetching timeline events...');

      final result =
          await timelineEventsService.getOfferTimelineEvents(offerId);

      if (result['success']) {
        log('Timeline events successfully fetched.');

        final dynamic data = result['data'];
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);

        timelineEvents.assignAll(dataList);
      } else {
        log('Error fetching timeline events: ${result['error']}');
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
      log('Fetch operation completed.');
    }
  }
}
