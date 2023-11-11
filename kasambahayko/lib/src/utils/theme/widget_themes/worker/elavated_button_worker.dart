import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';

class WorkerElavatedButtonTheme {
  WorkerElavatedButtonTheme._();

  static final elavatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        foregroundColor: whitecolor,
        backgroundColor: secondarycolor,
        side: const BorderSide(color: secondarycolor),
        padding: const EdgeInsets.symmetric(vertical: buttonheight)),
  );
}
