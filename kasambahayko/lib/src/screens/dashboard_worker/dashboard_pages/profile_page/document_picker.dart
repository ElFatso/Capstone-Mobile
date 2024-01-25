import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_valid_documents_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_valid_documents_update.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_worker.dart';

class DocumentUploadScreen extends GetView {
  final String documentType;
  final UpdateDocumentsController documentUploadController =
      UpdateDocumentsController();

  DocumentUploadScreen({Key? key, required this.documentType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: WorkerTheme.theme,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(defaultpadding),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Select a document to upload',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Divider(
                    color: greycolor,
                    thickness: 1,
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
                    ),
                    onPressed: () {
                      pickDocument();
                    },
                    child: Text(
                      "Pick a Document",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        final List<PlatformFile> files = result.files;

        // Assuming only one file is picked
        final PlatformFile pickedFile = files.first;

        final String? uuid = Get.find<UserInfoController>().userInfo['uuid'];

        if (uuid != null) {
          final Map<String, dynamic> uploadResult =
              await documentUploadController.uploadDocument(
                  uuid, File(pickedFile.path!), documentType);

          if (uploadResult['success']) {
            // Document upload successful
            final List<String> documentUrls =
                List<String>.from(uploadResult['data']['fileUrl']);

            // Assuming only one document is uploaded
            final String fullDocumentUrl =
                '${ApiConstants.baseUrl}${documentUrls.first}';

            // Update the user's document URL or handle it as needed
            log('Document URL: $fullDocumentUrl');

            final documentsController = Get.find<DocumentsController>();
            await documentsController.fetchDocuments(uuid);

            Get.to(() => const WorkerDashboardScreen(
                  initialPage: WorkerDashboardSections.profile,
                ));
          } else {
            // Handle the case where document upload was not successful
          }
        } else {
          // Handle the case where 'uuid' is null
        }
      } else {
        // User canceled the document picker
      }
    } catch (error) {
      // Handle errors during document picking
      log('Error during document picking: $error');
    }
  }
}
