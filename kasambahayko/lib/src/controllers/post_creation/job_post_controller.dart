import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/post_creation_service/job_post_service.dart';

class JobPostsController extends GetxController {
  final JobPostsService jobPostsService = JobPostsService();
  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> jobPosts = <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  Future<void> fetchJobPosts(String uuid) async {
    try {
      isLoading.value = true;
      final result = await jobPostsService.getJobPosts(uuid);

      if (result['success']) {
        final data = result['data'] as List<dynamic>;
        final mappedData =
            data.map((item) => item as Map<String, dynamic>).toList();
        jobPosts.assignAll(mappedData);
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> reloadJobPosts(String uuid) async {
    try {
      isLoading.value = true;
      final result = await jobPostsService.reloadJobPosts(uuid);

      if (result['success']) {
        final data = result['data'] as List<dynamic>;
        final mappedData =
            data.map((item) => item as Map<String, dynamic>).toList();
        jobPosts.assignAll(mappedData);
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
