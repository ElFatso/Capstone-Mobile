import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/screens/login/login_form_widget.dart';
import 'package:kasambahayko/src/screens/login/login_header_widget.dart';
import 'package:kasambahayko/src/utils/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Theme(
      data: StandardTheme.theme,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(defaultsize),
              child: Column(
                children: [
                  LoginHeaderWidget(size: size),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
