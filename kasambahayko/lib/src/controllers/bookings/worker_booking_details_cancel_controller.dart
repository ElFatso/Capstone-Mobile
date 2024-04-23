import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/bookings_service/worker_booking_details_cancel_service.dart';

class WorkerBookingDetailsCancelController extends GetxController {
  final WorkerBookingDetailsCancelService cancelService =
      WorkerBookingDetailsCancelService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> cancelBooking(String bookingId, String reason) async {
    try {
      isLoading.value = true;

      final result = await cancelService.cancelBooking(bookingId, reason);

      if (result['success']) {
        log('Booking cancelled successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error cancelling booking. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
