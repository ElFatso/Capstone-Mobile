import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/constants/text_strings.dart';
import 'package:kasambahayko/src/screens/login/login_screen.dart';

class SignupHeaderWidget extends StatefulWidget {
  const SignupHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<SignupHeaderWidget> createState() => _SignupHeaderWidgetState();
}

class _SignupHeaderWidgetState extends State<SignupHeaderWidget> {
  int userType = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage('assets/images/welcome.png'),
          height: widget.size.height * 0.15,
        ),
        Text(signupTitle, style: Theme.of(context).textTheme.displayLarge),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                alreadyhaveanAccount,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: () => Get.to(() => const LoginScreen()),
                child: const Text(
                  signin,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
