import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/constants/text_strings.dart';
import 'package:kasambahayko/src/screens/signup/signup_screen.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage('assets/images/welcome.png'),
          height: size.height * 0.2,
        ),
        Text(loginTitle, style: Theme.of(context).textTheme.displayLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              donthaveanAccount,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () => Get.to(() => const SignupScreen()),
              child: const Text(
                createAccount,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
