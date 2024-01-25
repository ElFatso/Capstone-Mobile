import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/user_service/worker_valid_documents_update.dart';

class UpdateDocumentsController extends GetxController {
  final UpdateDocumentsService uploadService = UpdateDocumentsService();

  Future<Map<String, dynamic>> uploadDocument(
      String uuid, File pdfDocument, String documentType) async {
    try {
      final result = await uploadService.uploadDocument(
        uuid,
        pdfDocument,
        documentType,
      );

      if (result['success']) {
        log('Document upload successful');
        log('Uploaded document data: ${result['data']}');
      } else {
        log('Document upload failed. Error: ${result['error']}');
      }

      return result;
    } catch (error) {
      log('Error during document upload: $error');
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
