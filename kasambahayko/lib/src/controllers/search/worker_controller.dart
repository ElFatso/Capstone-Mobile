import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/distance_calculator/location_service.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/routing/api/search_service/search_service.dart';

class WorkerController extends GetxController {
  final SearchService workerService = SearchService();
  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> workers = <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;
  final RxList<String> selectedServiceNames = <String>[].obs;
  final RxList<Map<String, dynamic>> filteredWorkers =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchWorkers() async {
    try {
      isLoading.value = true;
      final workerList = await workerService.fetchWorkers();

      if (workerList != null) {
        final userInfo = Get.find<UserInfoController>().userInfo;
        final workersWithDistance =
            await Future.wait(workerList.map((worker) async {
          worker['distance'] = LocationService.getDistance(
            worker['city_municipality'],
            userInfo['distances'],
          );
          return worker;
        }));

        workers.assignAll(workersWithDistance);
        filteredWorkers.assignAll(workersWithDistance);
      } else {
        error.value = 'Failed to load workers';
      }
    } finally {
      isLoading.value = false;
    }
  }

  void applyServiceFilter() {
    final selectedNames = selectedServiceNames.toSet();
    log("Selected Service Names: $selectedNames");

    if (selectedNames.isEmpty) {
      filteredWorkers.assignAll(workers);
    } else {
      final filtered = workers.where((worker) {
        final servicesList = worker['services'] ?? [];
        log("Worker's Services: $servicesList");
        final workerServiceNames =
            servicesList.map((service) => service['service_name']).toSet();

        log("Worker's Service Names: $workerServiceNames");

        // Check if the worker provides all of the selected services.
        final hasMatchingService = selectedNames
            .every((selectedName) => workerServiceNames.contains(selectedName));

        if (hasMatchingService) {
          log("Worker with matching services: $worker");
        } else {
          log("Worker with no matching services: $worker");
        }

        return hasMatchingService;
      }).toList();

      filteredWorkers.assignAll(filtered);
      log("Filtered Workers: ${filtered.toString()}");
    }
  }

  int compareWorkersByDistance(Map<String, dynamic> a, Map<String, dynamic> b) {
    // Use the "distance" property for comparison
    final double distanceA = a['distance'];
    final double distanceB = b['distance'];

    // Sort in ascending order (from lowest to highest)
    return distanceA.compareTo(distanceB);
  }

  // Function to sort workers by distance
  void sortWorkersByDistance(bool ascending) {
    // Sort the filteredWorkers list using the custom comparison function
    filteredWorkers.sort((a, b) {
      if (ascending) {
        return compareWorkersByDistance(a, b);
      } else {
        return compareWorkersByDistance(b, a);
      }
    });
  }

  int compareWorkersByPayRate(Map<String, dynamic> a, Map<String, dynamic> b) {
    final double hourlyRateA = double.parse(a['hourly_rate'].toString());
    final double hourlyRateB = double.parse(b['hourly_rate'].toString());

    // Sort in ascending order (from lowest to highest hourly rate)
    return hourlyRateA.compareTo(hourlyRateB);
  }

  // Function to sort workers by hourly rate
  void sortWorkersByPayRate(bool ascending) {
    filteredWorkers.sort((a, b) {
      if (ascending) {
        return compareWorkersByPayRate(a, b);
      } else {
        return compareWorkersByPayRate(b, a);
      }
    });
  }
}
