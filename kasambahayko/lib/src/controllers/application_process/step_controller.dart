import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kasambahayko/src/routing/api/application_process_service/step_service.dart';

class StepController extends GetxController {
  final StepService stepService = StepService();

  final RxBool isLoading = true.obs;
  final RxString currentStep = ''.obs;
  final RxString error = ''.obs;

  Future<void> fetchApplicationStage(String jobId) async {
    try {
      isLoading.value = true;
      final result = await stepService.getApplicationStage(jobId);

      if (result['success']) {
        final dynamic data = result['data'];

        final messageValue =
            data is Map<String, dynamic> ? data['message'] : data;

        currentStep.value = '$messageValue';
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
