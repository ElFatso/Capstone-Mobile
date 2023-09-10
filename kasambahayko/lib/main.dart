import 'package:flutter/material.dart';
import 'package:kasambahayko/src/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:kasambahayko/src/utils/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: KKAppTheme.lightTheme,
      darkTheme: KKAppTheme.darkTheme,
      home: const KKWelcomeScreen(),
    );
  }
}
