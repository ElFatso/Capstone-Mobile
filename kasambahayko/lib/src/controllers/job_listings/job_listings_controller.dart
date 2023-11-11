import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/distance_calculator/location_service.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/routing/api/job_listings_service/job_listings_service.dart';

class JobListingsController extends GetxController {
  final JobListingsService jobListingsService = JobListingsService();
  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> jobPosts = <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;
  final String selectedServiceName = '';
  final String selectedLivingArrangement = '';
  final RxList<Map<String, dynamic>> filteredListings =
      <Map<String, dynamic>>[].obs;

  Future<void> fetchJobListings(String uuid) async {
    try {
      isLoading.value = true;
      final jobListings = await jobListingsService.getJobListings(uuid);

      if (jobListings != null) {
        final userInfo = Get.find<UserInfoController>().userInfo;
        final jobsWithDistance =
            await Future.wait(jobListings.map((worker) async {
          worker['distance'] = LocationService.getDistance(
            worker['city_municipality'],
            userInfo['distances'],
          );
          return worker;
        }));
        jobPosts.assignAll(jobsWithDistance);
        filteredListings.assignAll(jobsWithDistance);
        log('Job listings fetched successfully');
      } else {
        error.value = 'Failed to load job listings';
        log('Failed to load job listings');
      }
    } catch (error) {
      log('Error fetching job listings: ${error.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> reloadJobListings(String uuid) async {
    try {
      isLoading.value = true;
      final jobListings = await jobListingsService.reloadJobListings(uuid);

      if (jobListings != null) {
        final userInfo = Get.find<UserInfoController>().userInfo;
        final jobsWithDistance =
            await Future.wait(jobListings.map((worker) async {
          worker['distance'] = LocationService.getDistance(
            worker['city_municipality'],
            userInfo['distances'],
          );
          return worker;
        }));
        jobPosts.assignAll(jobsWithDistance);
        filteredListings.assignAll(jobsWithDistance);
        log('Job listings fetched successfully');
      } else {
        error.value = 'Failed to load job listings';
        log('Failed to load job listings');
      }
    } catch (error) {
      log('Error fetching job listings: ${error.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters(
      String selectedServiceName, String selectedLivingArrangement) {
    log("Selected Service Name: $selectedServiceName");
    log("Selected Living Arrangement: $selectedLivingArrangement");

    if (selectedServiceName == "None" && selectedLivingArrangement == "None") {
      // If both are "None," display all the listings
      filteredListings.assignAll(jobPosts);
      return; // No need to continue with further filtering
    }

    final filtered = jobPosts.where((post) {
      final servicesList = post['services'] ?? [];
      final listingServiceName =
          servicesList.map((service) => service['service_name']).toSet();

      final livingArrangementList = post['living_arrangement'] ?? [];

      final hasMatchingService = selectedServiceName == "None" ||
          listingServiceName.contains(selectedServiceName);
      final hasMatchingLivingArrangement =
          selectedLivingArrangement == "None" ||
              livingArrangementList.contains(selectedLivingArrangement);

      return hasMatchingService && hasMatchingLivingArrangement;
    }).toList();

    filteredListings.assignAll(filtered);
    log("Filtered Listings: ${filtered.toString()}");
  }

  int compareListingsByDistance(
      Map<String, dynamic> a, Map<String, dynamic> b) {
    // Use the "distance" property for comparison
    final double distanceA = a['distance'];
    final double distanceB = b['distance'];

    // Sort in ascending order (from lowest to highest)
    return distanceA.compareTo(distanceB);
  }

  // Function to sort workers by distance
  void sortListingsByDistance(bool ascending) {
    // Sort the filteredWorkers list using the custom comparison function
    filteredListings.sort((a, b) {
      if (ascending) {
        return compareListingsByDistance(a, b);
      } else {
        return compareListingsByDistance(b, a);
      }
    });
  }

  int compareListingsByJobPostingDate(
      Map<String, dynamic> a, Map<String, dynamic> b) {
    // Use the "job_posting_date" property for comparison
    final DateTime dateA = DateTime.parse(a['job_posting_date']);
    final DateTime dateB = DateTime.parse(b['job_posting_date']);

    // Sort in ascending order (from oldest to newest)
    return dateA.compareTo(dateB);
  }

// Function to sort listings by job posting date
  void sortListingsByJobPostingDate(bool ascending) {
    // Sort the filteredListings list using the custom comparison function
    filteredListings.sort((a, b) {
      if (ascending) {
        return compareListingsByJobPostingDate(a, b);
      } else {
        return compareListingsByJobPostingDate(b, a);
      }
    });
  }
}
