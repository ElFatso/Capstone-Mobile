import 'package:flutter/material.dart';

class RememberMeCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool value;

  const RememberMeCheckbox({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  RememberMeCheckboxState createState() => RememberMeCheckboxState();
}

class RememberMeCheckboxState extends State<RememberMeCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.value,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              widget.onChanged(newValue);
            }
          },
        ),
        const Text('Remember Me'),
      ],
    );
  }
}
