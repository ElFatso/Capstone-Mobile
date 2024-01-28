import 'package:dio/dio.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';

class ChatHistoryService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getMessages(
      String senderUUID, String receiverUUID) async {
    final Uri messagesUri =
        Uri.parse('${ApiConstants.baseUrl}/messages/$senderUUID/$receiverUUID');

    try {
      final response = await dio.get(
        messagesUri.toString(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': response.data};
      } else {
        final Map<String, dynamic> errorData = response.data;
        return {'success': false, 'error': errorData['message']};
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
