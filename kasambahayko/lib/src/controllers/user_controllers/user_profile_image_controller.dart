import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/routing/api/user_service/user_profile_image.dart';

class ProfileImageUploadController {
  final ProfileImageUploadService uploadService = ProfileImageUploadService();

  Future<Map<String, dynamic>> uploadProfileImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        final File imageFile = File(image.path);
        final String uuid = Get.find<UserInfoController>().userInfo['uuid'];
        return await uploadService.uploadProfileImage(uuid, imageFile.path);
      } else {
        return {
          'success': false,
          'error': 'No image selected.',
        };
      }
    } catch (error) {
      return {
        'success': false,
        'error': 'An error occurred: $error',
      };
    }
  }
}
