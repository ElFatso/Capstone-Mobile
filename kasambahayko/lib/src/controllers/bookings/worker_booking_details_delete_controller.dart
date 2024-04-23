import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/bookings_service/worker_booking_details_delete_service.dart';

class WorkerBookingDetailsDeleteController extends GetxController {
  final WorkerBookingDetailsDeleteService deleteService =
      WorkerBookingDetailsDeleteService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> deleteBooking(String bookingId) async {
    try {
      isLoading.value = true;

      final result = await deleteService.deleteBooking(bookingId);

      if (result['success']) {
        log('Booking request deleted successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error deleting booking request. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
