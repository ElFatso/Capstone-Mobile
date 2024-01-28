import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/bookings_service/worker_booking_request_service.dart';

class WorkerBookingRequestController extends GetxController {
  final WorkerBookingRequestService workerBookingRequestService =
      WorkerBookingRequestService();

  final RxBool isLoading = true.obs;
  final RxMap bookingRequestData = {}.obs;
  final RxString error = ''.obs;

  Future<void> fetchBookingRequest(String bookingId) async {
    try {
      isLoading.value = true;
      final result =
          await workerBookingRequestService.getBookingRequest(bookingId);

      if (result['success']) {
        final dynamic data = result['data'];
        bookingRequestData.value = data;
        log('Booking request data fetched: $bookingRequestData');
      } else {
        error.value = result['error'];
        log('Error fetching booking request: $error');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
