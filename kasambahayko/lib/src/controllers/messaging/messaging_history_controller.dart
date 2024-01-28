import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/messaging/messaging_history_service.dart';

class ChatHistoryController extends GetxController {
  final ChatHistoryService chatHistoryService = ChatHistoryService();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchMessages(String senderUUID, String receiverUUID) async {
    try {
      isLoading.value = true;
      final result =
          await chatHistoryService.getMessages(senderUUID, receiverUUID);

      if (result['success']) {
        final List<dynamic> data = result['data'];
        final List<Map<String, dynamic>> messagesData =
            data.map((e) => e as Map<String, dynamic>).toList();
        messages.assignAll(messagesData);
        log('Messages fetched successfully: $messages');
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
