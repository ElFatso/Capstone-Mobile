import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/timeline_create_service.dart';

class CreateTimelineEventController extends GetxController {
  final CreateTimelineEventService timelineEventService =
      CreateTimelineEventService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> postTimelineEvent(
      String applicationId, Map<String, dynamic> timelineEvent) async {
    try {
      isLoading.value = true;

      final result = await timelineEventService.postTimelineEvent(
        applicationId,
        timelineEvent,
      );

      if (result['success']) {
        log('Timeline event added successfully!');
      } else {
        error.value = result['error'];
        log('Error adding timeline event. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
