import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/text_strings.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordInputField({
    super.key,
    required this.controller,
  });

  @override
  PasswordInputFieldState createState() => PasswordInputFieldState();
}

class PasswordInputFieldState extends State<PasswordInputField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: password,
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
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
