import 'package:flutter/material.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/elavated_button_theme.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/text_theme.dart';

class KKAppTheme {
  KKAppTheme._();

  //Light Theme
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: KKTextTheme.lightTextTheme,
      elevatedButtonTheme: KKElavatedButtonTheme.lightElavatedButtonTheme,
      outlinedButtonTheme: KKOutlinedButtonTheme.lightOutlinedButtonTheme);

  //Dark Theme
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: KKTextTheme.darkTextTheme,
      elevatedButtonTheme: KKElavatedButtonTheme.darkElavatedButtonTheme,
      outlinedButtonTheme: KKOutlinedButtonTheme.darkOutlinedButtonTheme);
}
