import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasambahayko/src/constants/colors.dart';

class KKTextTheme {
  KKTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
        fontSize: 28.0, fontWeight: FontWeight.w800, color: blackcolor),
    displayMedium: GoogleFonts.montserrat(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: blackcolor),
    displaySmall: GoogleFonts.montserrat(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: blackcolor),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
        fontSize: 28.0, fontWeight: FontWeight.w800, color: whitecolor),
    displayMedium: GoogleFonts.montserrat(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: whitecolor),
    displaySmall: GoogleFonts.montserrat(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: whitecolor),
  );
}
