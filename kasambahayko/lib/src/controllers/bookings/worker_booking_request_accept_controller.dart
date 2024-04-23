import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/bookings_service/worker_booking_request_accept_service.dart';

class WorkerBookingRequestAcceptController extends GetxController {
  final WorkerBookingRequestAcceptService acceptService =
      WorkerBookingRequestAcceptService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> acceptBookingRequest(String bookingId) async {
    try {
      isLoading.value = true;

      final result = await acceptService.acceptBookingRequest(bookingId);

      if (result['success']) {
        log('Booking request accepted successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error accepting booking request. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
