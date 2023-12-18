import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/distance_calculator/location_service.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/routing/api/job_listings_service/applied_service.dart';

class AppliedJobsController extends GetxController {
  final AppliedJobsService appliedJobsService = AppliedJobsService();
  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> appliedJobs = <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;
  final String selectedServiceName = '';
  final String selectedLivingArrangement = '';
  final RxList<Map<String, dynamic>> filteredAppliedJobs =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchAppliedJobs(String uuid) async {
    try {
      isLoading.value = true;
      final jobs = await appliedJobsService.getAppliedJobs(uuid);

      if (jobs != null) {
        final userInfo = Get.find<UserInfoController>().userInfo;
        final jobsWithDistance = await Future.wait(jobs.map((job) async {
          job['post']['distance'] = LocationService.getDistance(
            job['post']['city_municipality'],
            userInfo['distances'],
          );
          return job;
        }));
        appliedJobs.assignAll(jobsWithDistance);
        filteredAppliedJobs.assignAll(jobsWithDistance);
        log('Applied jobs fetched successfully');
      } else {
        error.value = 'Failed to load applied jobs';
        log('Failed to load applied jobs');
      }
    } catch (error) {
      log('Error fetching applied jobs: ${error.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> reloadAppliedJobs(String uuid) async {
    try {
      isLoading.value = true;
      final jobs = await appliedJobsService.reloadAppliedJobs(uuid);

      if (jobs != null) {
        final userInfo = Get.find<UserInfoController>().userInfo;
        final jobsWithDistance = await Future.wait(jobs.map((job) async {
          job['post']['distance'] = LocationService.getDistance(
            job['post']['city_municipality'],
            userInfo['distances'],
          );
          return job;
        }));
        appliedJobs.assignAll(jobsWithDistance);
        filteredAppliedJobs.assignAll(jobsWithDistance);
        log(filteredAppliedJobs.toString());
        log('Applied jobs fetched successfully');
      } else {
        error.value = 'Failed to load applied jobs';
        log('Failed to load applied jobs');
      }
    } catch (error) {
      log('Error fetching applied jobs: ${error.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters(
      String selectedServiceName, String selectedLivingArrangement) {
    log("Selected Service Name: $selectedServiceName");
    log("Selected Living Arrangement: $selectedLivingArrangement");

    if (selectedServiceName == "None" && selectedLivingArrangement == "None") {
      // If both are "None," display all the applied jobs
      filteredAppliedJobs.assignAll(appliedJobs);
      return; // No need to continue with further filtering
    }

    final filtered = appliedJobs.where((job) {
      final servicesList = job['post']['services'] ?? [];
      final jobServiceNameList =
          servicesList.map((service) => service['service_name']).toSet();

      final jobLivingArrangementList = job['post']['living_arrangement'] ?? [];

      final hasMatchingService = selectedServiceName == "None" ||
          jobServiceNameList.contains(selectedServiceName);
      final hasMatchingLivingArrangement =
          selectedLivingArrangement == "None" ||
              jobLivingArrangementList.contains(selectedLivingArrangement);

      return hasMatchingService && hasMatchingLivingArrangement;
    }).toList();

    filteredAppliedJobs.assignAll(filtered);
    log("Filtered Applied Jobs: ${filtered.toString()}");
  }

  // Function to sort applied jobs by distance
  int compareJobsByDistance(Map<String, dynamic> a, Map<String, dynamic> b) {
    // Use the "distance" property for comparison
    final double distanceA = a['post']['distance'];
    final double distanceB = b['post']['distance'];

    // Sort in ascending order (from lowest to highest)
    return distanceA.compareTo(distanceB);
  }

  void sortAppliedJobsByDistance(bool ascending) {
    // Sort the appliedJobs list using the custom comparison function
    filteredAppliedJobs.sort((a, b) {
      if (ascending) {
        return compareJobsByDistance(a, b);
      } else {
        return compareJobsByDistance(b, a);
      }
    });
  }

  // Function to sort applied jobs by job posting date
  int compareJobsByJobPostingDate(
      Map<String, dynamic> a, Map<String, dynamic> b) {
    // Use the "job_posting_date" property for comparison
    final DateTime dateA = DateTime.parse(a['post']['job_posting_date']);
    final DateTime dateB = DateTime.parse(b['post']['job_posting_date']);

    // Sort in ascending order (from oldest to newest)
    return dateA.compareTo(dateB);
  }

  void sortAppliedJobsByJobPostingDate(bool ascending) {
    // Sort the appliedJobs list using the custom comparison function
    filteredAppliedJobs.sort((a, b) {
      if (ascending) {
        return compareJobsByJobPostingDate(a, b);
      } else {
        return compareJobsByJobPostingDate(b, a);
      }
    });
  }
}
