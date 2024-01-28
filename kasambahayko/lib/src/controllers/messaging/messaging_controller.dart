import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/controllers/messaging/messaging_history_controller.dart';
import 'package:kasambahayko/src/routing/api/messaging/messaging_service.dart';

class ChatController extends GetxController {
  final MessagingService messagingService = MessagingService();

  @override
  void onInit() {
    super.onInit();
    messagingService.initializeSocket();
    messagingService.receiveMessage((data) {
      log('Message received: $data');
      final chatHistoryController = Get.find<ChatHistoryController>();
      chatHistoryController.messages.add(data);
    });
  }

  @override
  void onClose() {
    super.onClose();
    messagingService.dispose();
  }

  void joinRoom(String senderUUID, String receiverUUID) {
    messagingService.joinRoom(senderUUID, receiverUUID);
  }

  void sendMessage(String senderUUID, String receiverUUID, String message) {
    messagingService.sendMessage(senderUUID, receiverUUID, message);
  }
}
