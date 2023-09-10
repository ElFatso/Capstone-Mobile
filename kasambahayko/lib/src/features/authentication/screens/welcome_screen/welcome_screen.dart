// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/constants/text_strings.dart';
import 'package:kasambahayko/src/utils/theme/theme.dart';
import 'package:kasambahayko/src/utils/theme/widget_themes/text_theme.dart';

class KKWelcomeScreen extends StatelessWidget {
  const KKWelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Theme(
        data: KKAppTheme.lightTheme,
        child: Scaffold(
            body: Container(
                padding: const EdgeInsets.all(defaultsize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: const AssetImage('assets/images/welcome.png'),
                      height: height * 0.6,
                    ),
                    Column(
                      children: [
                        Text(welcomeTitle,
                            style: KKTextTheme.lightTextTheme.displayLarge),
                        Text(
                          welcomeDescription,
                          style: KKTextTheme.lightTextTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(login.toUpperCase()),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(signup.toUpperCase()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
