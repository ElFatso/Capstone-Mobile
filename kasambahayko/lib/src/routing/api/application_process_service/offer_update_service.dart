import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class UpdateOfferService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> updateOffer(
    String jobpostId,
    String applicationId,
    Map<String, dynamic> offer,
  ) async {
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}/employer/post/$jobpostId/offer/$applicationId');

    try {
      final response = await dio.put(
        uri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {'offer': offer},
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Offer updated'};
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
