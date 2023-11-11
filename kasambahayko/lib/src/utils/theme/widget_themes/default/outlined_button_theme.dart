import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';

class OutlinedTheme {
  OutlinedTheme._();

  static final outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
        foregroundColor: blackcolor,
        side: const BorderSide(color: blackcolor),
        padding: const EdgeInsets.symmetric(vertical: buttonheight)),
  );
}
