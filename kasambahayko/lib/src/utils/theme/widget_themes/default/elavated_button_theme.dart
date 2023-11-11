import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';

class ElavatedTheme {
  ElavatedTheme._();

  static final elavatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        foregroundColor: whitecolor,
        backgroundColor: blackcolor,
        side: const BorderSide(color: blackcolor),
        padding: const EdgeInsets.symmetric(vertical: buttonheight)),
  );
}
