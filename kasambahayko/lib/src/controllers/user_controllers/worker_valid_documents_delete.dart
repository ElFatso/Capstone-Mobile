import 'dart:developer';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/user_service/worker_valid_documents_delete.dart';

class DeleteDocumentsController extends GetxController {
  final DeleteDocumentsService documentDeleteService = DeleteDocumentsService();
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> deleteDocument(String documentId) async {
    try {
      isLoading.value = true;

      final result = await documentDeleteService.deleteDocument(documentId);

      if (result['success']) {
        log('Document deleted successfully!');
        // Handle success, e.g., show a success message
      } else {
        // Handle error, e.g., show an error message
        error.value = result['error'];
        log('Error deleting document. Error: ${result['error']}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
