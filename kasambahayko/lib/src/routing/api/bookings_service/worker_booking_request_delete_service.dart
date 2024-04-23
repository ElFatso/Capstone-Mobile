import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class WorkerBookingRequestDeleteService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> deleteBookingRequest(String bookingId) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}/worker/booking-request/$bookingId');

    try {
      final response = await dio.delete(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Booking request deleted'};
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
