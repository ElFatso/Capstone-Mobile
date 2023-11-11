import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/bindings/app_bindings.dart';
import 'package:kasambahayko/src/screens/welcome/welcome_screen.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: KKTextTheme.textTheme,
      ),
      home: const WelcomeScreen(),
      initialBinding: AppBindings(),
    );
  }
}
