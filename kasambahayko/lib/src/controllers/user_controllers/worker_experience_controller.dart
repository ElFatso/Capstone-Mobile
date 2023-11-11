import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:kasambahayko/src/routing/api/user_service/worker_experience_update.dart';

class WorkerExperienceController extends ChangeNotifier {
  final WorkerExperienceService _service = WorkerExperienceService();
  String _resultMessage = '';
  bool _isLoading = false;

  String get resultMessage => _resultMessage;
  bool get isLoading => _isLoading;

  Future<void> updateWorkerExperienceInfo(String uuid, String workExperience,
      double hourlyRate, List<String> skillsString) async {
    try {
      _isLoading = true;
      notifyListeners();

      final message = await _service.updateWorkerExperience(
          uuid, workExperience, hourlyRate, skillsString);

      _resultMessage = message;
      log('Worker experience information updated successfully');
    } catch (error) {
      _resultMessage = 'Error: ${error.toString()}';
      log('Error updating worker experience information: ${error.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
