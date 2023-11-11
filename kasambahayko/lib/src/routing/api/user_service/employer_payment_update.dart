import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class EmployerPaymentInfoService {
  final Dio dio = Dio();

  Future<String> updatePaymentInfo(
    String uuid,
    List<Map<String, dynamic>> paymentMethods,
    String paymentFrequency,
  ) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}/employer/update-info/payment');
    try {
      final response = await dio.patch(
        uri.toString(),
        data: {
          'uuid': uuid,
          'paymentMethods': paymentMethods,
          'paymentFrequency': paymentFrequency,
        },
      );

      if (response.statusCode == 200) {
        return ('Payment information updated!');
      } else {
        throw Exception('Failed to update payment information');
      }
    } catch (error) {
      rethrow;
    }
  }
}
