import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/distance_calculator/location_service.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/applicants_service.dart';

class JobApplicantsController extends GetxController {
  final JobApplicantsService jobApplicantsService = JobApplicantsService();
  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> totalApplicants =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> jobApplicants =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredJobApplicants =
      <Map<String, dynamic>>[].obs;
  final RxInt topCount = 0.obs;
  final RxString error = ''.obs;

  Future<void> fetchJobApplicants(String jobId) async {
    try {
      isLoading.value = true;
      final result = await jobApplicantsService.getJobApplicants(jobId);

      if (result['success']) {
        final data = result['data'] as List<dynamic>;
        final userInfo = Get.find<UserInfoController>().userInfo;
        final applicantWithDistance = await Future.wait(data.map((item) async {
          final Map<String, dynamic> mappedItem = item as Map<String, dynamic>;
          mappedItem['information']['distance'] = LocationService.getDistance(
            mappedItem['information']['city_municipality'],
            userInfo['distances'],
          );

          return mappedItem;
        }));
        totalApplicants.assignAll(applicantWithDistance);
        jobApplicants.assignAll(applicantWithDistance);
        filteredJobApplicants.assignAll([]);
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }

  void setTopCount(int count) {
    topCount.value = count;
  }

  void transferToQApplicant(int index) {
    final transferredApplicant = jobApplicants[index];
    filteredJobApplicants.add(transferredApplicant);
    jobApplicants.removeAt(index);
  }

  void transferToApplicant(int index) {
    final transferredApplicant = filteredJobApplicants[index];
    jobApplicants.add(transferredApplicant);
    filteredJobApplicants.removeAt(index);
  }

  void getTopApplicants() {
    int newTopCount = topCount.value;

    while (filteredJobApplicants.length < newTopCount) {
      if (jobApplicants.isNotEmpty) {
        transferToQApplicant(0);
      } else {
        break;
      }
    }

    while (filteredJobApplicants.length > newTopCount) {
      transferToApplicant(filteredJobApplicants.length - 1);
    }
  }

  int compareApplicantsByDistance(
      Map<String, dynamic> a, Map<String, dynamic> b) {
    // Use the "distance" property for comparison
    final double distanceA = a['information']['distance'];
    final double distanceB = b['information']['distance'];

    // Sort in ascending order (from lowest to highest)
    return distanceA.compareTo(distanceB);
  }

  // Function to sort workers by distance
  void sortApplicantsByDistance(bool ascending) {
    // Sort the filteredWorkers list using the custom comparison function
    jobApplicants.sort((a, b) {
      if (ascending) {
        return compareApplicantsByDistance(a, b);
      } else {
        return compareApplicantsByDistance(b, a);
      }
    });
  }

  int compareApplicantsByPayRate(
      Map<String, dynamic> a, Map<String, dynamic> b) {
    final double hourlyRateA =
        double.parse(a['information']['hourly_rate'].toString());
    final double hourlyRateB =
        double.parse(b['information']['hourly_rate'].toString());

    // Sort in ascending order (from lowest to highest hourly rate)
    return hourlyRateA.compareTo(hourlyRateB);
  }

  // Function to sort workers by hourly rate
  void sortApplicantsByPayRate(bool ascending) {
    jobApplicants.sort((a, b) {
      if (ascending) {
        return compareApplicantsByPayRate(a, b);
      } else {
        return compareApplicantsByPayRate(b, a);
      }
    });
  }
}
