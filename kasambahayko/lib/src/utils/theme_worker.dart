import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/text_theme.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/worker/elavated_button_worker.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/worker/outlined_button_worker.dart';

class WorkerTheme {
  WorkerTheme._();

  static ThemeData theme = ThemeData(
      textTheme: KKTextTheme.textTheme,
      colorScheme: const ColorScheme.light(primary: secondarycolor),
      elevatedButtonTheme: WorkerElavatedButtonTheme.elavatedButtonTheme,
      outlinedButtonTheme: WorkerOutlinedButtonTheme.outlinedButtonTheme);
}
