import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/bookings_service/worker_booking_details_service.dart';

class WorkerBookingDetailsController extends GetxController {
  final WorkerBookingDetailsService workerBookingDetailsService =
      WorkerBookingDetailsService();

  final RxBool isLoading = true.obs;
  final RxMap bookingData = {}.obs;
  final RxString error = ''.obs;

  Future<void> fetchBooking(String bookingId) async {
    try {
      isLoading.value = true;
      final result = await workerBookingDetailsService.getBooking(bookingId);

      if (result['success']) {
        final dynamic data = result['data'];
        bookingData.value = data;
        log('Booking data fetched: $bookingData');
      } else {
        error.value = result['error'];
        log('Error fetching booking: $error');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
