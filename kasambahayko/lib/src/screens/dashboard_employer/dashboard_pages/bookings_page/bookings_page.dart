import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/card/custom_card.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/status_highlight.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/bookings/employer_booking_details_controller.dart';
import 'package:kasambahayko/src/controllers/bookings/employer_booking_request_controller.dart';
import 'package:kasambahayko/src/controllers/bookings/employer_bookings_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/bookings_page/booking_details.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/bookings_page/booking_request.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: defaultpadding, left: defaultpadding, right: defaultpadding),
      child: Scaffold(
        body: GetBuilder<EmployerBookingsController>(
          init: EmployerBookingsController(),
          builder: (controller) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                    top: 12,
                  ),
                  child: CustomCard(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () {},
                        child: const Text('Filter Bookings'),
                      ),
                    ),
                  ),
                ),
                if (controller.isLoading.value)
                  const Center(child: CircularProgressIndicator())
                else if (controller.error.isNotEmpty)
                  Center(child: Text('Error: ${controller.error}'))
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.employerBookings.length,
                      itemBuilder: (context, index) {
                        final booking = controller.employerBookings[index];
                        final jobTitle = booking['title'];
                        final worker = booking['worker'];
                        final service = booking['service'];
                        final progress = booking['progress'];
                        final date = booking['date'];
                        final time = booking['time'];
                        final type = booking['type'];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: CustomCard(
                            child: Column(
                              children: [
                                Text(
                                  jobTitle,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  worker,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      CupertinoIcons.tag,
                                      size: 24.0,
                                    ),
                                    const SizedBox(width: 8),
                                    if (progress == 'Confirmed')
                                      StatusHighlight(
                                        label: service,
                                        highlightColor: greencolor,
                                        text: 'Confirmed',
                                      )
                                    else if (progress == 'In Progress')
                                      StatusHighlight(
                                        label: service,
                                        highlightColor: bluecolor,
                                        text: 'In Progress',
                                      )
                                    else if (progress == 'Completed')
                                      StatusHighlight(
                                        label: service,
                                        highlightColor: primarycolor,
                                        text: 'Completed',
                                      )
                                    else if (progress == 'Cancelled')
                                      StatusHighlight(
                                        label: service,
                                        highlightColor: redcolor,
                                        text: 'Cancelled',
                                      )
                                    else if (progress == 'Pending')
                                      StatusHighlight(
                                        label: service,
                                        highlightColor: yellowcolor,
                                        text: 'Pending',
                                      )
                                    else if (progress == 'Declined')
                                      StatusHighlight(
                                        label: service,
                                        highlightColor: orangecolor,
                                        text: 'Declined',
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Divider(
                                  color: greycolor,
                                  thickness: 1,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$date - $time',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  onPressed: () async {
                                    if (type == 'booking') {
                                      final employerBookingDetailsController =
                                          Get.find<
                                              EmployerBookingDetailsController>();
                                      await employerBookingDetailsController
                                          .fetchBooking(
                                              booking['id'].toString());
                                      Get.to(() => const BookingDetailsScreen(),
                                          transition: Transition.rightToLeft);
                                    } else if (type == 'booking-request') {
                                      final employerBookingRequestController =
                                          Get.find<
                                              EmployerBookingRequestController>();
                                      await employerBookingRequestController
                                          .fetchBookingRequest(
                                              booking['id'].toString());
                                      Get.to(() => const BookingRequestScreen(),
                                          transition: Transition.rightToLeft);
                                    }
                                  },
                                  child: const Text('View Details'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
