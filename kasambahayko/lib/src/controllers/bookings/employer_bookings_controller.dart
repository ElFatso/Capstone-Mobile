import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/bookings_service/employer_bookings_service.dart';

class EmployerBookingsController extends GetxController {
  final EmployerBookingsService employerBookingsService =
      EmployerBookingsService();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> employerBookings =
      <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchEmployerBookings(String employerId) async {
    try {
      isLoading.value = true;
      final result = await employerBookingsService.getAllBookings(employerId);

      if (result['success']) {
        final dynamic data = result['data'];

        if (data is List<dynamic>) {
          employerBookings.assignAll(data.cast<Map<String, dynamic>>());
          log(employerBookings.toString());
        } else {
          employerBookings.assignAll([]);
          log(employerBookings.toString());
        }
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
