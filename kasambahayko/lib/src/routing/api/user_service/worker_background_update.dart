import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class WorkerBackgroundService {
  final Dio dio = Dio();

  Future<String> updateWorkerBackgroundInfo(
      String uuid,
      String education,
      List<Map<String, dynamic>> certifications,
      List<Map<String, dynamic>> languages) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}/worker/update-info/background');

    try {
      final response = await dio.patch(
        uri.toString(),
        data: {
          'uuid': uuid,
          'education': education,
          'certifications': certifications,
          'languages': languages,
        },
      );

      if (response.statusCode == 200) {
        return 'Worker Background Information updated!';
      } else {
        throw Exception('Failed to update worker background information');
      }
    } catch (error) {
      rethrow;
    }
  }
}
