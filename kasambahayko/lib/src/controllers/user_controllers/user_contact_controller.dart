import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kasambahayko/src/routing/api/user_service/employer_contact_update.dart';

class UserContactController extends ChangeNotifier {
  final UserContactInfoService _service = UserContactInfoService();
  String _resultMessage = '';
  bool _isLoading = false;

  String get resultMessage => _resultMessage;
  bool get isLoading => _isLoading;

  Future<void> updateUserContactInfo(
      String uuid, String phoneNumber, String email) async {
    try {
      _isLoading = true;
      notifyListeners();

      final message =
          await _service.updateUserContactInfo(uuid, phoneNumber, email);

      _resultMessage = message;
      log('Contact information updated successfully');
    } catch (error) {
      _resultMessage = 'Error: ${error.toString()}';
      log('Error updating contact information: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
