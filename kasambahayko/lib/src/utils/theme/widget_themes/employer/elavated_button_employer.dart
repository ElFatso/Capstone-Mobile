import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';

class EmployerElavatedButtonTheme {
  EmployerElavatedButtonTheme._();

  static final elavatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        foregroundColor: whitecolor,
        backgroundColor: primarycolor,
        side: const BorderSide(color: primarycolor),
        padding: const EdgeInsets.symmetric(vertical: buttonheight)),
  );
}
