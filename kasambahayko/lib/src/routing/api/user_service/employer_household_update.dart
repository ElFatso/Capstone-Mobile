import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class EmployerHouseholdInfoService {
  final Dio dio = Dio();

  Future<String> updateHouseholdInfo(
    String uuid,
    String householdSize,
    Map<String, dynamic> pets,
    String specificNeeds,
  ) async {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}/employer/update-info/household');
    try {
      final response = await dio.patch(
        uri.toString(),
        data: {
          'uuid': uuid,
          'householdSize': householdSize,
          'pets': pets,
          'specificNeeds': specificNeeds,
        },
      );

      if (response.statusCode == 200) {
        return ('Household information updated!');
      } else {
        throw Exception('Failed to update contact information');
      }
    } catch (error) {
      rethrow;
    }
  }
}
