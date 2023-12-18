import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class CreateOfferService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> postOffer(String jobpostId, String applicationId,
      Map<String, dynamic> offer) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/employer/post/$jobpostId/offer/$applicationId');

    try {
      final response = await dio.post(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'offer': offer},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return {'success': true, 'offer_id': responseData['offer_id']};
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
