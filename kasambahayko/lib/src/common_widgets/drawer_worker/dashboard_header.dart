import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';

class DashboardHeader extends StatelessWidget {
  final double appBarHeight;

  const DashboardHeader({
    Key? key,
    required this.appBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = Get.find<UserInfoController>().userInfo;
    final firstName = userInfo['firstName'].toString();
    final lastName = userInfo['lastName'].toString();
    final email = userInfo['email'].toString();
    final imageUrl = userInfo['imageUrl'].toString();
    final truncatedEmail = email.split('@')[0];
    final double drawerWidth = MediaQuery.of(context).size.width;

    return Container(
      width: drawerWidth,
      height: appBarHeight,
      padding: const EdgeInsets.only(top: 12, left: 16, bottom: 12),
      color: secondarycolor,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: SizedBox(
                width: 60,
                height: 60,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$firstName $lastName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                truncatedEmail,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
