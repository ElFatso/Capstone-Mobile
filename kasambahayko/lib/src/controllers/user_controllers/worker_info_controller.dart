import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kasambahayko/src/routing/api/user_service/worker_info_update.dart';

class WorkerInfoController extends ChangeNotifier {
  final WorkerInfoService _service = WorkerInfoService();
  String _resultMessage = '';
  bool _isLoading = false;

  String get resultMessage => _resultMessage;
  bool get isLoading => _isLoading;

  Future<void> updateWorkerInfo(String uuid, String bio,
      List<Map<String, dynamic>> servicesOffered, String availability) async {
    try {
      _isLoading = true;
      notifyListeners();

      final message = await _service.updateWorkerInfo(
          uuid, bio, servicesOffered, availability);

      _resultMessage = message;
      log('Worker information updated successfully');
    } catch (error) {
      _resultMessage = 'Error: ${error.toString()}';
      log('Error updating worker information: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
