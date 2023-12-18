import 'dart:developer';

import 'package:get/get.dart';
import 'package:kasambahayko/src/routing/api/configurations.dart';

class ConfigurationsController extends GetxController {
  final ConfigurationService configurationService = ConfigurationService();

  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> configurations =
      <Map<String, dynamic>>[].obs;
  final RxString error = ''.obs;

  String employerInfoFrequencyOfPayment = '';
  // String jobPostingJobTitle = '';
  // String jobPostingJobDescription = '';
  String jobPostingLivingArrangement = '';
  String offerFrequencyOfPayment = '';
  // String offerSalary = '';
  String offerBenefits = '';
  // String kasambahayInfoRates = '';
  String kasambahayInfoLanguages = '';
  String kasambahayInfoCertifications = '';
  String kasambahayInfoSkills = '';

  Future<void> fetchConfigurations() async {
    try {
      isLoading.value = true;
      final result = await configurationService.getAllConfigurations();

      if (result['success']) {
        final dynamic data = result['data'];

        if (data is List) {
          configurations.assignAll(data.cast<Map<String, dynamic>>());

          // Extracting values from configurations
          employerInfoFrequencyOfPayment = configurations[0]['config_value'];
          // jobPostingJobTitle = configurations[1]['config_value'];
          // jobPostingJobDescription = configurations[2]['config_value'];
          jobPostingLivingArrangement = configurations[3]['config_value'];
          offerFrequencyOfPayment = configurations[4]['config_value'];
          // offerSalary = configurations[5]['config_value'];
          offerBenefits = configurations[6]['config_value'];
          // kasambahayInfoRates = configurations[7]['config_value'];
          kasambahayInfoLanguages = configurations[8]['config_value'];
          kasambahayInfoCertifications = configurations[9]['config_value'];
          kasambahayInfoSkills = configurations[10]['config_value'];

          log(configurations.toString());
        } else {
          // Handle the case when data is not a List
        }
      } else {
        error.value = result['error'];
      }
    } finally {
      isLoading.value = false;
    }
  }
}
