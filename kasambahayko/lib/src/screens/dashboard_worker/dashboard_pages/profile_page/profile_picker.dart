import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/user_profile_image_controller.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_worker.dart';

class ImageSelectionScreen extends GetView {
  final ProfileImageUploadController imageUploadController =
      ProfileImageUploadController();

  ImageSelectionScreen({super.key});

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
                    'What would you like to upload?',
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
                      getImage(ImageSource.camera);
                    },
                    child: Text(
                      "Take a Photo",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
                    ),
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Text(
                      "Choose from Gallery",
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

  void getImage(ImageSource source) async {
    final result = await imageUploadController.uploadProfileImage(source);
    if (result['success']) {
      // The image was successfully uploaded
      final imageUrl = result['data']['imageUrl'];

      // Remove 'server' from the imageUrl
      final modifiedImageUrl = imageUrl.replaceAll('server', '');

      // Construct the full URL
      final fullImageUrl = '${ApiConstants.baseUrl}$modifiedImageUrl';

      // Update the user's image URL
      final userInfoController = Get.find<UserInfoController>();
      userInfoController.userInfo['imageUrl'] = fullImageUrl;

      log('Image URL: $fullImageUrl');

      Get.to(() => const WorkerDashboardScreen(
            initialPage: WorkerDashboardSections.profile,
          ));
    } else {}
  }
}
