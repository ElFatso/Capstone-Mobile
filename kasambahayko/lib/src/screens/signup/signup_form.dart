import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/barangay_input_field.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/city_input_field.dart';
import 'package:kasambahayko/src/common_widgets/toggle_buttons/user_type_toggle.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/signup_controller.dart';
import 'package:kasambahayko/src/screens/login/login_screen.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  SignupFormState createState() => SignupFormState();
}

class SignupFormState extends State<SignupForm> {
  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;
  int currentStep = 0;
  String fName = '';
  String lName = '';
  String email = '';
  String phone = '';
  String password = '';
  String cPassword = '';
  String? selectedCity;
  String? selectedBarangay;
  String street = '';
  String selectedUserType = 'household employer';
  void handleUserTypeChange(String userType) {
    setState(() {
      selectedUserType = userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: blackcolor,
        ),
      ),
      child: Column(
        children: [
          UserTypeToggle(
            onUserTypeChanged: handleUserTypeChange,
            initialUserType: selectedUserType, // Pass the current user type
          ),
          Stepper(
            steps: getsteps(),
            currentStep: currentStep,
            onStepTapped: (step) => setState(() => currentStep = step),
            controlsBuilder:
                (BuildContext context, ControlsDetails controlsDetails) {
              final lastStep = currentStep == getsteps().length - 1;
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    if (currentStep != 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controlsDetails.onStepCancel,
                          child: const Text('BACK'),
                        ),
                      ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controlsDetails.onStepContinue,
                        child: Text(lastStep ? 'CONFIRM' : 'NEXT'),
                      ),
                    ),
                  ],
                ),
              );
            },
            onStepContinue: () {
              final isLastStep = currentStep == getsteps().length - 1;

              if (isLastStep) {
                final signupController = Get.find<RegistrationController>();
                signupController.registerUser(
                  fName,
                  lName,
                  email,
                  phone,
                  password,
                  selectedUserType,
                  selectedCity!,
                  selectedBarangay!,
                  street,
                );
                Get.to(() => const LoginScreen());
                return;
              }

              setState(() => currentStep += 1);
            },
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
          ),
        ],
      ),
    );
  }

  List<Step> getsteps() => [
        Step(
          state: currentStep >= 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Personal"),
          content: Column(
            children: [
              const SizedBox(height: 12),
              TextFormField(
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Enter your first name',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    fName = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Enter your last name',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    lName = value;
                  });
                },
              ),
            ],
          ),
        ),
        Step(
          state: currentStep >= 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text("Contact"),
          content: Column(
            children: [
              const SizedBox(height: 12),
              TextFormField(
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Enter your email address',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Enter your phone number',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
              ),
            ],
          ),
        ),
        Step(
          state: currentStep >= 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text("Location"),
          content: Column(
            children: [
              const SizedBox(height: 12),
              CityInputField(
                onChanged: (String value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              BarangayInputField(
                selectedCity: selectedCity,
                onChanged: (String value) {
                  setState(() {
                    selectedBarangay = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Street',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Enter your street',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    street = value;
                  });
                },
              ),
            ],
          ),
        ),
        Step(
          state: currentStep >= 4 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text("Security"),
          content: Column(
            children: [
              const SizedBox(height: 12),
              TextFormField(
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Enter your password',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                obscureText: !isCPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Enter your password again',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isCPasswordVisible = !isCPasswordVisible;
                      });
                    },
                    icon: Icon(
                      isCPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    cPassword = value;
                  });
                },
              ),
            ],
          ),
        ),
      ];
}
