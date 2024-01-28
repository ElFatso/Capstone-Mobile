import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/bookings/worker_booking_request_controller.dart';
import 'package:kasambahayko/src/controllers/messaging/messaging_controller.dart';
import 'package:kasambahayko/src/controllers/messaging/messaging_history_controller.dart';
import 'package:kasambahayko/src/utils/theme_worker.dart';

class ChatRequestScreen extends StatelessWidget {
  const ChatRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatHistoryController = Get.find<ChatHistoryController>().messages;
    final booking =
        Get.find<WorkerBookingRequestController>().bookingRequestData;
    final messageController = TextEditingController();
    return Theme(
      data: WorkerTheme.theme,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: secondarycolor,
          automaticallyImplyLeading: false,
          leadingWidth: MediaQuery.of(context).size.width * 0.8,
          leading: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: defaultpadding),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Obx(
                    () {
                      final profileUrl =
                          booking['employer']['profile_url'].toString();
                      return ClipOval(
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.network(
                            profileUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Obx(() {
                final firstName = booking['employer']['first_name'].toString();
                final lastName = booking['employer']['last_name'].toString();
                return Text(
                  '$firstName $lastName',
                  style: const TextStyle(
                    color: whitecolor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: chatHistoryController.length,
                    itemBuilder: (context, index) {
                      final history = chatHistoryController[index];
                      final chat = history['message'];
                      final timeStamp = history['createdAt'];

                      final dateTime = DateTime.parse(timeStamp).toLocal();
                      final formattedTime =
                          DateFormat('EEE, h:mm a').format(dateTime);
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: defaultpadding, right: defaultpadding),
                        child: Column(
                          children: [
                            if (history['senderUUID'] ==
                                booking['employer']['uuid'])
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 250,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        chat,
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      formattedTime,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12.0),
                                    ),
                                    const SizedBox(height: 12.0),
                                  ],
                                ),
                              )
                            else if (history['senderUUID'] ==
                                booking['worker']['uuid'])
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 250,
                                      ),
                                      decoration: BoxDecoration(
                                        color: secondarycolor,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        chat,
                                        style: const TextStyle(
                                            fontSize: 16.0, color: whitecolor),
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      formattedTime,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12.0),
                                    ),
                                    const SizedBox(height: 12.0),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 4),
              const Divider(
                color: greycolor,
                thickness: 1,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        minLines: 1,
                        maxLines: null,
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.send,
                          size: 32, color: secondarycolor),
                      onPressed: () {
                        final chatController = Get.find<ChatController>();
                        chatController.messagingService.sendMessage(
                          booking['worker']['uuid'],
                          booking['employer']['uuid'],
                          messageController.text,
                        );
                        messageController.clear();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
