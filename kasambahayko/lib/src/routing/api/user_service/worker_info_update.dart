import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class WorkerInfoService {
  final Dio dio = Dio();

  Future<String> updateWorkerInfo(String uuid, String bio,
      List<Map<String, dynamic>> servicesOffered, String availability) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/worker/update-info/basics');

    try {
      final response = await dio.patch(
        uri.toString(),
        data: {
          'uuid': uuid,
          'bio': bio,
          'servicesOffered': servicesOffered,
          'availability': availability,
        },
      );

      if (response.statusCode == 200) {
        return 'Worker Information updated!';
      } else {
        throw Exception('Failed to update worker information');
      }
    } catch (error) {
      rethrow;
    }
  }
}
