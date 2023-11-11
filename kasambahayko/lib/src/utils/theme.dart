import 'package:flutter/material.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/default/elavated_button_theme.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/default/outlined_button_theme.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/text_theme.dart';

class StandardTheme {
  StandardTheme._();

  static ThemeData theme = ThemeData(
      textTheme: KKTextTheme.textTheme,
      elevatedButtonTheme: ElavatedTheme.elavatedButtonTheme,
      outlinedButtonTheme: OutlinedTheme.outlinedButtonTheme);
}
