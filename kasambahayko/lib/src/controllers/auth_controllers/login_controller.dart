import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/auth_service/login_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var rememberMe = RxBool(false);
  String errorMessage = '';

  Future<Map<String, dynamic>> signInWithEmailAndPassword() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final authService = LoginService(); // Initialize your API service class

    try {
      final response = await authService.login(email, password);

      if (response['success']) {
        // Successful login
        final Map<String, dynamic> data = response['data'];
        // Handle the successful response here
        log('Login successful: $data');
        return {'success': true, 'data': data};
      } else {
        // Handle login error
        errorMessage = response['error'] ?? 'An error occurred during login.';
        return {'success': false, 'error': errorMessage};
      }
    } catch (error) {
      // Handle network or other errors
      errorMessage = 'An error occurred during the request: $error';
      return {'success': false, 'error': errorMessage};
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
