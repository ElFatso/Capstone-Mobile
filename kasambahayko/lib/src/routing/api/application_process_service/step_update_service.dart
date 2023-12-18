import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class UpdateStepService {
  final Dio dio = Dio();

  Future<void> updateApplicationStage(String jobPostId, String stage) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/employer/post/$jobPostId/application/current-stage');

    try {
      await dio.post(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'stage': stage},
      );
    } catch (error) {
      throw Exception('Error updating application stage');
    }
  }
}
