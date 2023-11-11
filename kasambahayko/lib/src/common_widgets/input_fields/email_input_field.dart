import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/text_strings.dart';

class EmailInputField extends StatefulWidget {
  final TextEditingController controller;
  const EmailInputField({
    super.key,
    required this.controller,
  });

  @override
  EmailInputFieldState createState() => EmailInputFieldState();
}

class EmailInputFieldState extends State<EmailInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: email,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        hintText: 'Enter your email address',
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
