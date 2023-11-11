import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class JobListingsService {
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>?> fetchJobListings(String uuid) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/worker/job-listings/$uuid');

    try {
      final response = await dio.get(
        uri.toString(),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> jobListings =
            List<Map<String, dynamic>>.from(response.data);
        return jobListings;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getJobListings(String uuid) async {
    return await fetchJobListings(uuid);
  }

  Future<List<Map<String, dynamic>>?> reloadJobListings(String uuid) async {
    return await fetchJobListings(uuid);
  }
}
