import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class SearchService {
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>?> fetchWorkers() async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/employer/search/workers');

    try {
      final response = await dio.get(
        uri.toString(),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> workers =
            List<Map<String, dynamic>>.from(response.data);
        return workers;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
