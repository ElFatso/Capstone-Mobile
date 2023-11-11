import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasambahayko/src/constants/colors.dart';

class KKTextTheme {
  KKTextTheme._();

  static final textTheme = TextTheme(
    displayLarge: GoogleFonts.montserrat(
        fontSize: 36.0, fontWeight: FontWeight.w800, color: blackcolor),
    displayMedium: GoogleFonts.montserrat(
        fontSize: 32.0, fontWeight: FontWeight.w700, color: blackcolor),
    displaySmall: GoogleFonts.montserrat(
        fontSize: 28.0, fontWeight: FontWeight.w700, color: blackcolor),
    titleLarge: GoogleFonts.montserrat(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: blackcolor),
    titleMedium: GoogleFonts.montserrat(
        fontSize: 20.0, fontWeight: FontWeight.w600, color: blackcolor),
    titleSmall: GoogleFonts.montserrat(
        fontSize: 18.0, fontWeight: FontWeight.w500, color: blackcolor),
    bodyLarge: GoogleFonts.montserrat(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: blackcolor),
    bodyMedium: GoogleFonts.montserrat(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: blackcolor),
    bodySmall: GoogleFonts.montserrat(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: blackcolor),
  );
}
