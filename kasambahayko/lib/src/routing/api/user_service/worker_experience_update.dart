import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class WorkerExperienceService {
  final Dio dio = Dio();

  Future<String> updateWorkerExperience(String uuid, String workExperience,
      double hourlyRate, List<String> skillsString) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}/worker/update-info/experience');

    try {
      final response = await dio.patch(
        uri.toString(),
        data: {
          'uuid': uuid,
          'workExperience': workExperience,
          'hourlyRate': hourlyRate,
          'skillsString': skillsString,
        },
      );

      if (response.statusCode == 200) {
        return 'Worker Experience Information updated!';
      } else {
        throw Exception('Failed to update worker experience information');
      }
    } catch (error) {
      rethrow;
    }
  }
}
