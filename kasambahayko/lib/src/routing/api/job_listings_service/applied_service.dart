import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class AppliedJobsService {
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>?> fetchAppliedJobs(String uuid) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/worker/applied-jobs/$uuid');

    try {
      final response = await dio.get(uri.toString());

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> appliedJobs =
            List<Map<String, dynamic>>.from(response.data);
        return appliedJobs;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getAppliedJobs(String uuid) async {
    return await fetchAppliedJobs(uuid);
  }

  Future<List<Map<String, dynamic>>?> reloadAppliedJobs(String uuid) async {
    return await fetchAppliedJobs(uuid);
  }
}
