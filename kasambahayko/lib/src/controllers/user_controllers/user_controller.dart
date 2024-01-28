import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/user_service/user_service.dart';

class UserController extends GetxController {
  final UserService userIdService = UserService();

  final RxBool isLoading = true.obs;
  final RxString userId = RxString('');
  final RxString error = ''.obs;

  Future<void> fetchUserIdByUuid(String uuid) async {
    try {
      isLoading.value = true;
      final result = await userIdService.getUserIdByUuid(uuid);

      if (result['success']) {
        userId.value = result['userId'].toString();
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
