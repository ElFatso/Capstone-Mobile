import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class WorkerBookingsService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getAllBookings(String workerId) async {
    final Uri bookingsUri = Uri.parse(
        '${ApiConstants.baseUrl}/worker/$workerId/all-bookings/simple');

    try {
      final response = await dio.get(
        bookingsUri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': response.data};
      } else {
        final Map<String, dynamic> errorData = response.data;
        return {'success': false, 'error': errorData['error']};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
