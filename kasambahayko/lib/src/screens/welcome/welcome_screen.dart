import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/constants/text_strings.dart';
import 'package:kasambahayko/src/controllers/configurations_controller.dart';
import 'package:kasambahayko/src/screens/login/login_screen.dart';
import 'package:kasambahayko/src/screens/signup/signup_screen.dart';
import 'package:kasambahayko/src/utils/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Theme(
        data: StandardTheme.theme,
        child: Scaffold(
            backgroundColor: whitecolor,
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
                            style: Theme.of(context).textTheme.displayLarge),
                        Text(
                          welcomeDescription,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {
                              final configurationsController =
                                  Get.put(ConfigurationsController());
                              await configurationsController
                                  .fetchConfigurations();
                              Get.to(() => const LoginScreen());
                            },
                            child: Text(login.toUpperCase()),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final configurationsController =
                                  Get.put(ConfigurationsController());
                              await configurationsController
                                  .fetchConfigurations();
                              Get.to(() => const SignupScreen());
                            },
                            child: Text(signup.toUpperCase()),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }
}
