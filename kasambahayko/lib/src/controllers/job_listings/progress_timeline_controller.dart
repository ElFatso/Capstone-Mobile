import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/job_listings_service/progress_timeline_service.dart';

class ProgressTimelineController extends GetxController {
  final ProgressTimelineService timelineEventsService =
      ProgressTimelineService();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> progressTimeline =
      <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchProgressTimeline(
      String jobpostId, String applicationId) async {
    try {
      isLoading.value = true;

      final result = await timelineEventsService.getProgressTimeline(
          jobpostId, applicationId);

      if (result['success']) {
        log('Timeline events successfully fetched.');

        final dynamic data = result['data'];
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);

        progressTimeline.assignAll(dataList);
        log(progressTimeline.toString());
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
