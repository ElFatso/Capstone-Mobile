import 'package:flutter/material.dart';
import 'package:kasambahayko/src/screens/signup/signup_form.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/screens/signup/signup_header_widget.dart';
import 'package:kasambahayko/src/utils/theme.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Theme(
        data: StandardTheme.theme,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(defaultsize),
                child: Column(
                  children: [
                    SignupHeaderWidget(size: size),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const SignupForm())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
