import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/common_widgets/card/custom_card.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/booking_highlight.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/highlight.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/bookings/worker_booking_request_accept_controller.dart';
import 'package:kasambahayko/src/controllers/bookings/worker_booking_request_cancel_controller.dart';
import 'package:kasambahayko/src/controllers/bookings/worker_booking_request_controller.dart';
import 'package:kasambahayko/src/controllers/bookings/worker_booking_request_decline_controller.dart';
import 'package:kasambahayko/src/controllers/bookings/worker_booking_request_delete_controller.dart';
import 'package:kasambahayko/src/controllers/bookings/worker_bookings_controller.dart';
import 'package:kasambahayko/src/controllers/messaging/messaging_controller.dart';
import 'package:kasambahayko/src/controllers/messaging/messaging_history_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/user_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/bookings_page/chat_request_screen.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_worker.dart';
// ignore: library_prefixes
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class BookingRequestScreen extends StatelessWidget {
  const BookingRequestScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final booking =
        Get.find<WorkerBookingRequestController>().bookingRequestData;
    return Theme(
      data: WorkerTheme.theme,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(defaultpadding),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        final progress =
                            booking['booking_info']['booking_progress'];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 8),
                            if (progress == 'Confirmed')
                              const BookingHighlight(
                                label: 'Booking Overview',
                                highlightColor: greencolor,
                                text: 'Confirmed',
                              )
                            else if (progress == 'In Progress')
                              const BookingHighlight(
                                label: 'Booking Overview',
                                highlightColor: bluecolor,
                                text: 'In Progress',
                              )
                            else if (progress == 'Completed')
                              const BookingHighlight(
                                label: 'Booking Overview',
                                highlightColor: secondarycolor,
                                text: 'Completed',
                              )
                            else if (progress == 'Cancelled')
                              const BookingHighlight(
                                label: 'Booking Overview',
                                highlightColor: redcolor,
                                text: 'Cancelled',
                              )
                            else if (progress == 'Pending')
                              const BookingHighlight(
                                label: 'Booking Overview',
                                highlightColor: yellowcolor,
                                text: 'Pending',
                              )
                            else if (progress == 'Declined')
                              const BookingHighlight(
                                label: 'Booking Overview',
                                highlightColor: orangecolor,
                                text: 'Declined',
                              )
                            else if (progress == 'Expired')
                              const BookingHighlight(
                                label: 'Booking Overview',
                                highlightColor: greycolor,
                                text: 'Declined',
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ExpansionTile(
                      title: const Text("Job Details",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      children: <Widget>[
                        Obx(
                          () {
                            final jobTitle = booking['jobposting']['job_title'];
                            final service = booking['jobposting']['service']
                                ['service_name'];
                            final type = booking['jobposting']['job_type'];
                            final jobDescription =
                                booking['jobposting']['job_description'];
                            final jobStartDate =
                                booking['jobposting']['job_start_date'];
                            final jobEndDate =
                                booking['jobposting']['job_end_date'];
                            final livingArrangement =
                                booking['jobposting']['living_arrangement'];
                            final city =
                                booking['employer']['city_municipality'];
                            final finalCity =
                                city.toLowerCase().split(' ').map((word) {
                              if (word.isNotEmpty) {
                                return word[0].toUpperCase() +
                                    word.substring(1);
                              }
                              return '';
                            }).join(' ');
                            final street = booking['employer']['street'];
                            final barangay = booking['employer']['barangay'];
                            final cleanedBarangay =
                                barangay.toLowerCase().split(' ').map((word) {
                              if (word.isNotEmpty) {
                                return word[0].toUpperCase() +
                                    word.substring(1);
                              }
                              return '';
                            }).join(' ');
                            final finalBarangay = cleanedBarangay.replaceAll(
                                RegExp(r'[().]'), '');
                            final startTime24 =
                                booking['jobposting']['job_start_time'];
                            final parsedStartTime =
                                // ignore: prefer_interpolation_to_compose_strings
                                DateTime.parse("1970-01-01 " + startTime24);
                            final startTime =
                                DateFormat('h:mm a').format(parsedStartTime);
                            final endTime24 =
                                booking['jobposting']['job_end_time'];
                            final parsedEndTime =
                                // ignore: prefer_interpolation_to_compose_strings
                                DateTime.parse("1970-01-01 " + endTime24);
                            final endTime =
                                DateFormat('h:mm a').format(parsedEndTime);

                            final startDate =
                                DateFormat('yyyy-MM-dd').parse(jobStartDate);
                            final endDate =
                                DateFormat('yyyy-MM-dd').parse(jobEndDate);

                            final updatedStartDate =
                                startDate.add(const Duration(days: 1));
                            final updatedEndDate =
                                endDate.add(const Duration(days: 1));

                            final formattedJobStartDate =
                                DateFormat('yyyy-MM-dd')
                                    .format(updatedStartDate);
                            final formattedJobEndDate =
                                DateFormat('yyyy-MM-dd').format(updatedEndDate);
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Column(
                                children: [
                                  const SizedBox(height: 12),
                                  Text(
                                    jobTitle,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  const Divider(
                                    color: greycolor,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Highlight(
                                        label: 'Service:',
                                        text: service,
                                        highlightColor: orangecolor,
                                      ),
                                      const SizedBox(height: 12),
                                      Highlight(
                                        label: 'Type:',
                                        text: type,
                                        highlightColor: bluecolor,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Divider(
                                    color: greycolor,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Work Location',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$street, $finalBarangay, $finalCity',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(height: 4),
                                  const Divider(
                                    color: greycolor,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    jobDescription,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(height: 4),
                                  const Divider(
                                    color: greycolor,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'Duration',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '$formattedJobStartDate - $formattedJobEndDate',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Working Hours',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '$startTime - $endTime',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Living Arrangement',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    livingArrangement,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.justify,
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text("Offer Description",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      children: <Widget>[
                        Obx(
                          () {
                            final salary = double.parse(
                                booking['offer']['salary'].toString());

                            final formattedSalary = NumberFormat.currency(
                              locale: 'en_US',
                              symbol: '₱',
                            ).format(salary);
                            final frequency = booking['offer']['pay_frequency'];
                            List<dynamic> benefitsData =
                                booking['offer']['benefits'];
                            List<String> benefits = benefitsData
                                .map((dynamic element) => element.toString())
                                .map((String benefit) => '• $benefit')
                                .toList();

                            final selectedBenefits = benefits.join('\n');
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Column(
                                children: [
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'Salary',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            formattedSalary,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Pay Frequency',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            frequency,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Divider(
                                    color: greycolor,
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      selectedBenefits,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: const Text("Employer Information",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      children: <Widget>[
                        Obx(
                          () {
                            final firstName = booking['employer']['first_name'];
                            final lastName = booking['employer']['last_name'];
                            final profileUrl =
                                booking['employer']['profile_url'];
                            // final fullImageUrl =
                            //     '${ApiConstants.baseUrl}/assets/$profileUrl';
                            final phone = booking['employer']['phone'];
                            final email = booking['employer']['email'];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: Column(
                                children: [
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                        child: ClipOval(
                                          child: SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: Image.network(
                                              profileUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$firstName $lastName',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            email,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          InkWell(
                                            child: Text(
                                              phone,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            onTap: () => UrlLauncher.launchUrl(
                                                Uri.parse('tel:$phone')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 48),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            onPressed: () async {
                              final chatHistoryController =
                                  Get.find<ChatHistoryController>();
                              await chatHistoryController.fetchMessages(
                                  booking['worker']['uuid'],
                                  booking['employer']['uuid']);

                              final chatController = Get.find<ChatController>();
                              chatController.messagingService.joinRoom(
                                  booking['worker']['uuid'],
                                  booking['employer']['uuid']);
                              Get.to(() => const ChatRequestScreen(),
                                  transition: Transition.downToUp);
                            },
                            child: const Text('Send Message'),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () {
                        final progress =
                            booking['booking_info']['booking_progress'];
                        if (progress == 'Confirmed' ||
                            progress == 'In Progress' ||
                            progress == 'Pending') {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(width: 48),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                  ),
                                  onPressed: () async {
                                    final workerBookingRequestCancelController =
                                        Get.find<
                                            WorkerBookingRequestCancelController>();
                                    await workerBookingRequestCancelController
                                        .cancelBookingRequest(
                                            booking['booking_info']['dhb_id']
                                                .toString(),
                                            'I have other commitments');
                                    final workerBookingRequestController = Get
                                        .find<WorkerBookingRequestController>();
                                    await workerBookingRequestController
                                        .fetchBookingRequest(
                                            booking['booking_info']['dhb_id']
                                                .toString());
                                    final userController =
                                        Get.find<UserController>();
                                    final workerBookingsController =
                                        Get.find<WorkerBookingsController>();
                                    await workerBookingsController
                                        .fetchWorkerBookings(
                                            userController.userId.toString());
                                  },
                                  child: const Text('Cancel Booking'),
                                ),
                              ),
                              const SizedBox(width: 48),
                            ],
                          );
                        } else if (progress == 'Completed' ||
                            progress == 'Cancelled' ||
                            progress == 'Declined' ||
                            progress == 'Expired') {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(width: 48),
                              Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                  ),
                                  onPressed: () async {
                                    final workerBookingRequestDeleteController =
                                        Get.find<
                                            WorkerBookingRequestDeleteController>();
                                    await workerBookingRequestDeleteController
                                        .deleteBookingRequest(
                                            booking['booking_info']['dhb_id']
                                                .toString());
                                    final userController =
                                        Get.find<UserController>();
                                    final workerBookingsController =
                                        Get.find<WorkerBookingsController>();
                                    await workerBookingsController
                                        .fetchWorkerBookings(
                                            userController.userId.toString());
                                    Get.to(() => const WorkerDashboardScreen(
                                          initialPage:
                                              WorkerDashboardSections.bookings,
                                        ));
                                  },
                                  child: const Text('Delete Booking'),
                                ),
                              ),
                              const SizedBox(width: 48),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    Obx(
                      () {
                        final progress =
                            booking['booking_info']['booking_progress'];
                        if (progress == 'Pending') {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              const Divider(
                                color: greycolor,
                                thickness: 1,
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 300,
                                height: 150,
                                child: CustomCard(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(width: 24),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(16),
                                              ),
                                              onPressed: () async {
                                                final workerBookingRequestAcceptController =
                                                    Get.find<
                                                        WorkerBookingRequestAcceptController>();
                                                await workerBookingRequestAcceptController
                                                    .acceptBookingRequest(
                                                        booking['booking_info']
                                                                ['dhb_id']
                                                            .toString());
                                                final workerBookingRequestController =
                                                    Get.find<
                                                        WorkerBookingRequestController>();
                                                await workerBookingRequestController
                                                    .fetchBookingRequest(
                                                        booking['booking_info']
                                                                ['dhb_id']
                                                            .toString());
                                                final userController =
                                                    Get.find<UserController>();
                                                final workerBookingsController =
                                                    Get.find<
                                                        WorkerBookingsController>();
                                                await workerBookingsController
                                                    .fetchWorkerBookings(
                                                        userController.userId
                                                            .toString());
                                              },
                                              child: const Text('Accept'),
                                            ),
                                          ),
                                          const SizedBox(width: 24),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(width: 24),
                                          Expanded(
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(16),
                                              ),
                                              onPressed: () async {
                                                final workerBookingRequestDeclineController =
                                                    Get.find<
                                                        WorkerBookingRequestDeclineController>();
                                                await workerBookingRequestDeclineController
                                                    .declineBookingRequest(
                                                        booking['booking_info']
                                                                ['dhb_id']
                                                            .toString());
                                                final workerBookingRequestController =
                                                    Get.find<
                                                        WorkerBookingRequestController>();
                                                await workerBookingRequestController
                                                    .fetchBookingRequest(
                                                        booking['booking_info']
                                                                ['dhb_id']
                                                            .toString());
                                                final userController =
                                                    Get.find<UserController>();
                                                final workerBookingsController =
                                                    Get.find<
                                                        WorkerBookingsController>();
                                                await workerBookingsController
                                                    .fetchWorkerBookings(
                                                        userController.userId
                                                            .toString());
                                              },
                                              child: const Text('Decline'),
                                            ),
                                          ),
                                          const SizedBox(width: 24),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
