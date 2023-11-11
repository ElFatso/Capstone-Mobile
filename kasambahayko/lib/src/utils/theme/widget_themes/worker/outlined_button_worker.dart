import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';

class WorkerOutlinedButtonTheme {
  WorkerOutlinedButtonTheme._();

  static final outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
        foregroundColor: secondarycolor,
        side: const BorderSide(color: secondarycolor),
        padding: const EdgeInsets.symmetric(vertical: buttonheight)),
  );
}
