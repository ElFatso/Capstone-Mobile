import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const CustomCard({Key? key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 40.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
