import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome to the Notifications Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
