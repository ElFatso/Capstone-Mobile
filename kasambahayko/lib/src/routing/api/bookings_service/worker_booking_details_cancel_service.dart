import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class WorkerBookingDetailsCancelService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> cancelBooking(
      String bookingId, String reason) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}/worker/booking/$bookingId/cancel');

    try {
      final response = await dio.put(
        uri.toString(),
        data: {'reason': reason},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Booking cancelled'};
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
