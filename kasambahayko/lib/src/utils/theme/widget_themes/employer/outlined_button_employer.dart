import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';

class EmployerOutlinedButtonTheme {
  EmployerOutlinedButtonTheme._();

  static final outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
        foregroundColor: primarycolor,
        side: const BorderSide(color: primarycolor),
        padding: const EdgeInsets.symmetric(vertical: buttonheight)),
  );
}
