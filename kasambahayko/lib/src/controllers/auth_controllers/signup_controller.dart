import 'dart:developer';

import 'package:kasambahayko/src/routing/api/auth_service/signup_service.dart';

class RegistrationController {
  final RegistrationService registrationService = RegistrationService();

  Future<Map<String, dynamic>> registerUser(
      String firstName,
      String secondName,
      String email,
      String phone,
      String password,
      String userType,
      String city,
      String barangay,
      String street) async {
    try {
      log('Registering user with the following data:');
      log('First Name: $firstName');
      log('Second Name: $secondName');
      log('Email: $email');
      log('Phone: $phone');
      log('Password: $password');
      log('User Type: $userType');
      log('City: $city');
      log('Barangay: $barangay');
      log('Street: $street');

      final response = await registrationService.register(
        firstName,
        secondName,
        email,
        phone,
        password,
        userType,
        city,
        barangay,
        street,
      );

      log('Registration response: $response');

      if (response['success']) {
        return {'success': true, 'data': response['data']};
      } else {
        return {'success': false, 'error': response['error']};
      }
    } catch (error) {
      log('Error during registration: $error');
      return {
        'success': false,
        'error': 'An error occurred during the request: $error',
      };
    }
  }
}
