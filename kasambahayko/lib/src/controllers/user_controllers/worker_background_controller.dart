import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kasambahayko/src/routing/api/user_service/worker_background_update.dart';

class WorkerBackgroundController extends ChangeNotifier {
  final WorkerBackgroundService _service = WorkerBackgroundService();
  String _resultMessage = '';
  bool _isLoading = false;

  String get resultMessage => _resultMessage;
  bool get isLoading => _isLoading;

  Future<void> updateWorkerBackgroundInfo(
      String uuid,
      String education,
      List<Map<String, dynamic>> certifications,
      List<Map<String, dynamic>> languages) async {
    try {
      _isLoading = true;
      notifyListeners();

      final message = await _service.updateWorkerBackgroundInfo(
          uuid, education, certifications, languages);

      _resultMessage = message;
      log('Worker background information updated successfully');
    } catch (error) {
      _resultMessage = 'Error: ${error.toString()}';
      log('Error updating worker background information: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
