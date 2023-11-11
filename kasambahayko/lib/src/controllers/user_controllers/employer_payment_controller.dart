import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kasambahayko/src/routing/api/user_service/employer_payment_update.dart';

class EmployerPaymentInfoController extends ChangeNotifier {
  final EmployerPaymentInfoService _service = EmployerPaymentInfoService();
  String _resultMessage = '';
  bool _isLoading = false;

  String get resultMessage => _resultMessage;
  bool get isLoading => _isLoading;

  Future<void> updatePaymentInfo(
      String uuid,
      List<Map<String, dynamic>> paymentMethods,
      String paymentFrequency) async {
    try {
      _isLoading = true;
      notifyListeners();

      final message = await _service.updatePaymentInfo(
          uuid, paymentMethods, paymentFrequency);

      _resultMessage = message;
      log('Payment information updated successfully');
    } catch (error) {
      _resultMessage = 'Error: ${error.toString()}';
      log('Error updating payment information: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
