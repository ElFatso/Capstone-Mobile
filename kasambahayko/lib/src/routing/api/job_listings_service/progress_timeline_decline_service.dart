import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class DeclineJobOfferService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> declineJobOffer(String applicationId) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/worker/job-offer/$applicationId/decline');

    try {
      final response = await dio.post(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return {'success': true, 'offerId': responseData['offer_id']};
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
