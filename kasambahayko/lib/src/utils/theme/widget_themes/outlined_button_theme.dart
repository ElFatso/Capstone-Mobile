import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';

class KKOutlinedButtonTheme {
  KKOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(vertical: buttonheight)),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          foregroundColor: whitecolor,
          side: const BorderSide(color: whitecolor),
          padding: const EdgeInsets.symmetric(vertical: buttonheight)));
}
