import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/user_service/worker_valid_documents.dart';

class DocumentsController extends GetxController {
  final DocumentsService documentService = DocumentsService();
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;
  RxList<dynamic> documents = <dynamic>[].obs;

  Future<void> fetchDocuments(String uuid) async {
    try {
      final result = await documentService.fetchDocuments(uuid);

      if (result['success']) {
        hasError.value = false;
        errorMessage.value = '';
        documents.assignAll(result['data']);
        log("Document Data: $documents");
      } else {
        hasError.value = true;
        errorMessage.value = result['error'];
        log("Error: ${result['error']}");
      }
    } catch (error) {
      hasError.value = true;
      errorMessage.value = 'An error occurred during the request: $error';
      log("Error: $error");
    }
  }
}
