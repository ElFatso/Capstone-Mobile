import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/bookings_service/worker_bookings_service.dart';

class WorkerBookingsController extends GetxController {
  final WorkerBookingsService workerBookingsService = WorkerBookingsService();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> workerBookings =
      <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchWorkerBookings(String workerId) async {
    try {
      isLoading.value = true;
      final result = await workerBookingsService.getAllBookings(workerId);

      if (result['success']) {
        final dynamic data = result['data'];

        if (data is List<dynamic>) {
          workerBookings.assignAll(data.cast<Map<String, dynamic>>());
          log(workerBookings.toString());
        } else {
          workerBookings.assignAll([]);
          log(workerBookings.toString());
        }
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
