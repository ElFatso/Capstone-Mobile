import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kasambahayko/src/routing/api/user_service/employer_household_update.dart';

class EmployerHouseholdInfoController extends ChangeNotifier {
  final EmployerHouseholdInfoService _service = EmployerHouseholdInfoService();
  String _resultMessage = '';
  bool _isLoading = false;

  String get resultMessage => _resultMessage;
  bool get isLoading => _isLoading;

  Future<void> updateHouseholdInfo(String uuid, String householdSize,
      Map<String, dynamic> pets, String specificNeeds) async {
    try {
      _isLoading = true;
      notifyListeners();

      final message = await _service.updateHouseholdInfo(
          uuid, householdSize, pets, specificNeeds);

      _resultMessage = message;
      log('Household information updated successfully');
    } catch (error) {
      _resultMessage = 'Error: ${error.toString()}';
      log('Error updating household information: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
