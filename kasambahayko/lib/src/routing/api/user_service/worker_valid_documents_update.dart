import 'package:dio/dio.dart';
import 'dart:io';

import 'package:kasambahayko/src/routing/api/api_constants.dart';

class UpdateDocumentsService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> uploadDocument(
      String uuid, File pdfDocument, String documentType) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/document/upload/$uuid');

    try {
      FormData formData = FormData.fromMap({
        'type': documentType,
        'pdfDocument': await MultipartFile.fromFile(pdfDocument.path,
            filename: 'pdfDocument.pdf'),
      });

      final response = await dio.post(
        uri.toString(),
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
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
