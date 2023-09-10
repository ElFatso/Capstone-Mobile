import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';

class KKElavatedButtonTheme {
  KKElavatedButtonTheme._();

  static final lightElavatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        foregroundColor: whitecolor,
        backgroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(vertical: buttonheight)),
  );

  static final darkElavatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        foregroundColor: blackcolor,
        backgroundColor: whitecolor,
        side: const BorderSide(color: whitecolor),
        padding: const EdgeInsets.symmetric(vertical: buttonheight)),
  );
}
