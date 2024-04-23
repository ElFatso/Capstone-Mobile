import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/bookings_service/worker_booking_request_decline_service.dart';

class WorkerBookingRequestDeclineController extends GetxController {
  final WorkerBookingRequestDeclineService declineService =
      WorkerBookingRequestDeclineService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> declineBookingRequest(String bookingId) async {
    try {
      isLoading.value = true;

      final result = await declineService.declineBookingRequest(bookingId);

      if (result['success']) {
        log('Booking request declined successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error declining booking request. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
