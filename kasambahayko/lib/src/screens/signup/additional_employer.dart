import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/boolean_multiselect_input_field.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/single_item_dropdown.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/additional_employer.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/configurations_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/employer_profile_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/user_profile_image_controller.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';
import 'package:multiselect/multiselect.dart';

class EmployerAdditionalScreen extends StatefulWidget {
  const EmployerAdditionalScreen({super.key});

  @override
  EmployerAdditionalScreenState createState() =>
      EmployerAdditionalScreenState();
}

class EmployerAdditionalScreenState extends State<EmployerAdditionalScreen> {
  int currentStep = 0;
  final imageUploadController = Get.find<ProfileImageUploadController>();
  final imageUrl =
      Get.find<UserInfoController>().userInfo['imageUrl'].toString();
  final uuid = Get.find<UserInfoController>().userInfo['uuid'].toString();

  String size = '';
  String requirements = '';
  List<int> selectedPets = [0, 0, 0];
  final List<String> availablePets = [
    'Cat',
    'Dog',
    'Other Pets',
  ];
  final List<String> printingPets = [
    'cat',
    'dog',
    'otherPets',
  ];
  List<String?> selectedPaymentMethods = [];
  final List<String> availablePaymentMethods = [
    'Direct Deposit',
    'Paypal',
    'Gcash',
    'Cash',
    'Paymaya',
  ];
  String? selectedPaymentFrequency = 'Daily';
  List<String> availablePaymentFrequency = [];
  String bio = '';

  @override
  void initState() {
    super.initState();

    final configurationsController = Get.find<ConfigurationsController>();
    availablePaymentFrequency = configurationsController
        .employerInfoFrequencyOfPayment
        .split(',')
        .map((item) => item.trim())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> pets = Map.fromIterables(printingPets, selectedPets);
    List<Map<String, dynamic>> paymentMethods =
        selectedPaymentMethods.map((item) {
      return {"name": item};
    }).toList();
    return Theme(
      data: EmployerTheme.theme,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: defaultpadding, bottom: defaultpadding),
              child: Column(
                children: [
                  Text(
                    "Finishing Setup",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Stepper(
                    steps: getsteps(),
                    currentStep: currentStep,
                    onStepTapped: (step) => setState(() => currentStep = step),
                    controlsBuilder: (BuildContext context,
                        ControlsDetails controlsDetails) {
                      final lastStep = currentStep == getsteps().length - 1;
                      return Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Row(
                          children: [
                            if (currentStep != 0)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: controlsDetails.onStepCancel,
                                  child: const Text('BACK'),
                                ),
                              ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controlsDetails.onStepContinue,
                                child: Text(lastStep ? 'CONFIRM' : 'NEXT'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onStepContinue: () async {
                      final isLastStep = currentStep == getsteps().length - 1;

                      if (isLastStep) {
                        final completeEmployerProfileController =
                            Get.find<CompleteEmployerProfileController>();
                        final userInfoController =
                            Get.find<UserInfoController>();
                        final userInfo = userInfoController.userInfo;

                        await completeEmployerProfileController
                            .completeEmployerProfile(
                                uuid,
                                size,
                                pets,
                                requirements,
                                paymentMethods,
                                selectedPaymentFrequency!,
                                bio);

                        final employerProfileData =
                            await Get.find<EmployerProfileController>()
                                .fetchEmployerProfile(userInfo['uuid']);

                        Get.find<UserInfoController>().employerProfile.value =
                            employerProfileData!;

                        Get.to(() => const EmployerDashboardScreen(
                              initialPage: EmployerDashboardSections.home,
                            ));
                      } else {
                        setState(() => currentStep += 1);
                      }
                    },
                    onStepCancel: currentStep == 0
                        ? null
                        : () => setState(() => currentStep -= 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    final result = await imageUploadController.uploadProfileImage(source);
    if (result['success']) {
      // The image was successfully uploaded
      final imageUrl = result['data']['imageUrl'];
      log('Image URL: $imageUrl');

      // Remove 'server' from the imageUrl
      final modifiedImageUrl = imageUrl.replaceAll('server', '');

      // Construct the full URL
      final fullImageUrl = '${ApiConstants.baseUrl}$modifiedImageUrl';

      // Update the user's image URL
      final userInfoController = Get.find<UserInfoController>();
      userInfoController.userInfo['imageUrl'] = fullImageUrl;

      log('Image URL: $fullImageUrl');

      Get.off(() => const EmployerAdditionalScreen(),
          transition: Transition.fade);
    } else {}
  }

  List<Step> getsteps() => [
        Step(
          state: currentStep >= 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Household Information"),
          content: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Household Size",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Size of the Household',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    size = value;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Text("Pets in the Household",
                  style: Theme.of(context).textTheme.bodyMedium),
              BooleanMultiSelect(
                options: availablePets,
                selectedValues: selectedPets,
                onChanged: (selectedItems) {
                  setState(() {
                    selectedPets = selectedItems;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Requirements",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Special Requirements',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    requirements = value;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Step(
          state: currentStep >= 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text("Payment Information"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Payment Methods",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              DropDownMultiSelect(
                options: availablePaymentMethods,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                selectedValues: selectedPaymentMethods,
                onChanged: (selectedItems) {
                  setState(() {
                    selectedPaymentMethods = selectedItems.cast<String>();
                  });
                },
                decoration: InputDecoration(
                  labelText: "Select Payment Methods",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Text("Payment Frequency",
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              SingleItemDropdown(
                items: availablePaymentFrequency,
                selectedItem: selectedPaymentFrequency,
                onChanged: (value) {
                  selectedPaymentFrequency = value;
                },
                decoration: InputDecoration(
                  labelText: "Payment Frequency",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep >= 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text("Additional Information"),
          content: Column(
            children: [
              TextFormField(
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: "Bio",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Tell us more about your household',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    bio = value;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Step(
          state: currentStep >= 4 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text("Verification"),
          content: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                ),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                child: Text(
                  "Take a Photo",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                ),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                child: Text(
                  "Choose from Gallery",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFFAFAFA),
                child: Obx(
                  () {
                    final userInfoController = Get.find<UserInfoController>();
                    final imageUrl =
                        userInfoController.userInfo['imageUrl'].toString();
                    return ClipOval(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ];
}
