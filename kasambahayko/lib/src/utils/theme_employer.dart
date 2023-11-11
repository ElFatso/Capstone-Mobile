import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/employer/elavated_button_employer.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/employer/outlined_button_employer.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/text_theme.dart';

class EmployerTheme {
  EmployerTheme._();

  static ThemeData theme = ThemeData(
      textTheme: KKTextTheme.textTheme,
      colorScheme: const ColorScheme.light(primary: primarycolor),
      elevatedButtonTheme: EmployerElavatedButtonTheme.elavatedButtonTheme,
      outlinedButtonTheme: EmployerOutlinedButtonTheme.outlinedButtonTheme);
}
