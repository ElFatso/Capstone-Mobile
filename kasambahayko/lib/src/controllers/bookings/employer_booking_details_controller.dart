import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/bookings_service/employer_booking_details_service.dart';

class EmployerBookingDetailsController extends GetxController {
  final EmployerBookingDetailsService employerBookingDetailsService =
      EmployerBookingDetailsService();

  final RxBool isLoading = true.obs;
  final RxMap bookingData = {}.obs;
  final RxString error = ''.obs;

  Future<void> fetchBooking(String bookingId) async {
    try {
      isLoading.value = true;
      final result = await employerBookingDetailsService.getBooking(bookingId);

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
