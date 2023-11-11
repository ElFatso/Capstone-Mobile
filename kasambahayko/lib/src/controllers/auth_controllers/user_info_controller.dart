import 'package:get/get.dart';

class UserInfoController extends GetxController {
  RxMap userInfo = {}.obs;
  RxMap employerProfile = {}.obs;
  RxMap workerProfile = {}.obs;

  Map<String, dynamic> get userInfoMap {
    return Map<String, dynamic>.from(userInfo);
  }

  Map<String, dynamic> get employerProfileMap {
    return Map<String, dynamic>.from(employerProfile);
  }

  Map<String, dynamic> get workerProfileMap {
    return Map<String, dynamic>.from(workerProfile);
  }
}
