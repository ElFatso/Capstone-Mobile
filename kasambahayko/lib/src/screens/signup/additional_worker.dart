import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kasambahayko/src/common_widgets/card/custom_card.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/single_item_dropdown.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/additional_worker.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/user_profile_image_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_profile_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_valid_documents_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_valid_documents_delete.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/profile_page/document_details.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/profile_page/document_picker.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_worker.dart';
import 'package:multiselect/multiselect.dart';

class WorkerAdditionalScreen extends StatefulWidget {
  const WorkerAdditionalScreen({super.key});

  @override
  WorkerAdditionalScreenState createState() => WorkerAdditionalScreenState();
}

class WorkerAdditionalScreenState extends State<WorkerAdditionalScreen> {
  int currentStep = 0;
  final imageUploadController = Get.find<ProfileImageUploadController>();
  final imageUrl =
      Get.find<UserInfoController>().userInfo['imageUrl'].toString();
  final uuid = Get.find<UserInfoController>().userInfo['uuid'].toString();
  String bio = '';
  List<String?> selectedServices = [];
  final List<String> availableCare = [
    'Child Care',
    'Elder Care',
    'Pet Care',
    'House Services'
  ];
  String availability = '';
  String experiences = '';
  double hourlyRate = 10.0;
  TextEditingController hourlyRateController = TextEditingController();
  String skills = '';
  List<String?> selectedLanguages = [];
  final List<String> availableLanguages = [
    'English',
    'Filipino',
    'Cebuano',
    'Ilocano',
    'Hiligaynon',
    'Waray',
    'Kapampangan',
    'Bikol',
    'Bisaya',
  ];

  List<Map<String, dynamic>> referenceData = [
    {"id": 1, "code": "eng", "name": "English"},
    {"id": 2, "code": "fil", "name": "Filipino"},
    {"id": 3, "code": "ceb", "name": "Cebuano"},
    {"id": 4, "code": "ilo", "name": "Ilocano"},
    {"id": 5, "code": "hil", "name": "Hiligaynon"},
    {"id": 6, "code": "war", "name": "Waray"},
    {"id": 7, "code": "kap", "name": "Kapampangan"},
    {"id": 8, "code": "bik", "name": "Bikol"},
    {"id": 9, "code": "bis", "name": "Bisaya"},
  ];
  List<String?> selectedCertifications = [];
  final List<String> availableCertifications = [
    'NC II',
    'TESDA Certificate',
    'Red Cross First Aid Training',
    'BLS Certification',
    'Fire Safety Training',
    'Food Safety and Hygiene Training',
    'Brgy. Clearance',
    'Police Clearance',
    'NBI Clearance',
  ];
  String? selectedEducationLevel = 'Elementary';
  final List<String> availableEducationLevel = [
    'Elementary',
    'High School',
    'College',
    'Vocational',
    'Post Graduate',
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> services =
        selectedServices.asMap().entries.map((entry) {
      int serviceId = entry.key + 1;
      String? serviceName = entry.value;
      return {
        "service_id": serviceId,
        "service_name": serviceName,
      };
    }).toList();

    List<Map<String, dynamic>> certifications =
        selectedCertifications.map((item) {
      return {"name": item};
    }).toList();

    List<Map<String, dynamic>> languages = selectedLanguages.map((name) {
      final matchingLanguage =
          referenceData.firstWhere((language) => language['name'] == name);
      return {
        "id": matchingLanguage['id'],
        "code": matchingLanguage['code'],
        "name": name,
      };
    }).toList();
    List<String> originalSkills = skills.split(', ').toList();
    return Theme(
      data: WorkerTheme.theme,
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
                        final completeWorkerProfileController =
                            Get.find<CompleteWorkerProfileController>();
                        final userInfoController =
                            Get.find<UserInfoController>();
                        final userInfo = userInfoController.userInfo;

                        await completeWorkerProfileController
                            .completeWorkerProfile(
                                uuid,
                                availability,
                                bio,
                                certifications,
                                selectedEducationLevel!,
                                hourlyRate,
                                languages,
                                originalSkills,
                                experiences,
                                services);

                        final workerProfileData =
                            await Get.find<WorkerProfileController>()
                                .fetchWorkerProfile(userInfo['uuid']);
                        Get.find<UserInfoController>().workerProfile.value =
                            workerProfileData!;

                        Get.to(() => const WorkerDashboardScreen(
                              initialPage: WorkerDashboardSections.home,
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

      // Remove 'server' from the imageUrl
      final modifiedImageUrl = imageUrl.replaceAll('server', '');

      // Construct the full URL
      final fullImageUrl = '${ApiConstants.baseUrl}$modifiedImageUrl';

      // Update the user's image URL
      final userInfoController = Get.find<UserInfoController>();
      userInfoController.userInfo['imageUrl'] = fullImageUrl;

      log('Image URL: $fullImageUrl');

      Get.off(() => const WorkerAdditionalScreen(),
          transition: Transition.fade);
    } else {}
  }

  List<Step> getsteps() => [
        Step(
          state: currentStep >= 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Profile Information"),
          content: Column(
            children: [
              const SizedBox(height: 12),
              TextFormField(
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: "Bio",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Bio',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    bio = value;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              DropDownMultiSelect(
                options: availableCare,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                selectedValues: selectedServices,
                onChanged: (selectedItems) {
                  setState(() {
                    selectedServices = selectedItems.cast<String>();
                  });
                },
                decoration: InputDecoration(
                  labelText: "Services Offered",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Availability",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Availability',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    availability = value;
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
          title: const Text("Experiences and Skills"),
          content: Column(
            children: [
              const SizedBox(height: 12),
              TextFormField(
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: "Experiences",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Experiences',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    experiences = value;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              TextFormField(
                readOnly: true,
                controller: hourlyRateController
                  ..text = hourlyRate.toStringAsFixed(2),
                decoration: InputDecoration(
                  labelText: "Hourly Rate",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Hourly Rate',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_up),
                        onPressed: () {
                          setState(() {
                            hourlyRate += 10.0;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onPressed: () {
                          setState(() {
                            hourlyRate -= 10.0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              TextFormField(
                minLines: 1,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: "Additional Skills",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Additional Skills',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    skills = value;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
        Step(
          state: currentStep >= 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text("Background Information"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              SingleItemDropdown(
                items: availableEducationLevel,
                selectedItem: selectedEducationLevel,
                onChanged: (value) {
                  selectedEducationLevel = value;
                },
                decoration: InputDecoration(
                  labelText: "Education Level",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropDownMultiSelect(
                options: availableLanguages,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                selectedValues: selectedLanguages,
                onChanged: (selectedItems) {
                  setState(() {
                    selectedLanguages = selectedItems.cast<String>();
                  });
                },
                decoration: InputDecoration(
                  labelText: "Languages Spoken",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropDownMultiSelect(
                options: availableCertifications,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                selectedValues: selectedCertifications,
                onChanged: (selectedItems) {
                  setState(() {
                    selectedCertifications = selectedItems.cast<String>();
                  });
                },
                decoration: InputDecoration(
                  labelText: "Certifications",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep >= 4 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text("Verifcation"),
          content: Column(
            children: [
              ExpansionTile(
                title: const Text("Profile Picture",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
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
                          child: Obx(() {
                            final userInfoController =
                                Get.find<UserInfoController>();
                            final imageUrl = userInfoController
                                .userInfo['imageUrl']
                                .toString();
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
                          }),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                  title: const Text("Documents",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Obx(
                        () {
                          final documentsController =
                              Get.find<DocumentsController>();
                          final documents = documentsController.documents;

                          List getDocumentsByType(String type) {
                            return documents
                                .where((document) => document['type'] == type)
                                .toList();
                          }

                          List resumeDocuments = getDocumentsByType('resume');
                          List barangayClearanceDocuments =
                              getDocumentsByType('barangay clearance');
                          List policeClearanceDocuments =
                              getDocumentsByType('police clearance');
                          List nbiClearanceDocuments =
                              getDocumentsByType('nbi clearance');

                          return Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              children: [
                                if (getDocumentsByType('resume').isEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                                Text('RESUME',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(width: 24),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      const documentType =
                                                          'resume';
                                                      Get.to(
                                                          () =>
                                                              DocumentUploadScreen(
                                                                documentType:
                                                                    documentType,
                                                              ),
                                                          transition:
                                                              Transition.zoom);
                                                    },
                                                    child: const Text(
                                                        'Upload File'),
                                                  ),
                                                ),
                                                const SizedBox(width: 24),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('resume').isNotEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('Resume:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(width: 24),
                                                Expanded(
                                                  child: OutlinedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      final id =
                                                          resumeDocuments[0][
                                                                  'document_id']
                                                              .toString();

                                                      final deleteDocumentsController =
                                                          Get.find<
                                                              DeleteDocumentsController>();
                                                      await deleteDocumentsController
                                                          .deleteDocument(id);

                                                      final uuid = Get.find<
                                                              UserInfoController>()
                                                          .userInfo['uuid'];

                                                      final documentsController =
                                                          Get.find<
                                                              DocumentsController>();
                                                      await documentsController
                                                          .fetchDocuments(uuid);
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      const documentType =
                                                          'Resume';
                                                      final fileUrls =
                                                          resumeDocuments[0]
                                                              ['fileUrl'];
                                                      Get.to(
                                                          () => DocumentDetails(
                                                                documentType:
                                                                    documentType,
                                                                fileUrls:
                                                                    fileUrls,
                                                              ),
                                                          transition: Transition
                                                              .downToUp);
                                                    },
                                                    child: const Text('View'),
                                                  ),
                                                ),
                                                const SizedBox(width: 24),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('barangay clearance')
                                    .isEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                                Text('BARANGAY CLEARANCE',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(width: 24),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      const documentType =
                                                          'barangay clearance';
                                                      Get.to(
                                                          () =>
                                                              DocumentUploadScreen(
                                                                documentType:
                                                                    documentType,
                                                              ),
                                                          transition:
                                                              Transition.zoom);
                                                    },
                                                    child: const Text(
                                                        'Upload File'),
                                                  ),
                                                ),
                                                const SizedBox(width: 24),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('barangay clearance')
                                    .isNotEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('Barangay Clearance:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(width: 24),
                                                Expanded(
                                                  child: OutlinedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      final id =
                                                          barangayClearanceDocuments[
                                                                      0][
                                                                  'document_id']
                                                              .toString();

                                                      final deleteDocumentsController =
                                                          Get.find<
                                                              DeleteDocumentsController>();
                                                      await deleteDocumentsController
                                                          .deleteDocument(id);

                                                      final uuid = Get.find<
                                                              UserInfoController>()
                                                          .userInfo['uuid'];

                                                      final documentsController =
                                                          Get.find<
                                                              DocumentsController>();
                                                      await documentsController
                                                          .fetchDocuments(uuid);
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      const documentType =
                                                          'Barangay Clearance';
                                                      final fileUrls =
                                                          barangayClearanceDocuments[
                                                              0]['fileUrl'];
                                                      Get.to(
                                                          () => DocumentDetails(
                                                                documentType:
                                                                    documentType,
                                                                fileUrls:
                                                                    fileUrls,
                                                              ),
                                                          transition: Transition
                                                              .downToUp);
                                                    },
                                                    child: const Text('View'),
                                                  ),
                                                ),
                                                const SizedBox(width: 24),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('police clearance')
                                    .isEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                                Text('POLICE CLEARANCE',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(width: 24),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      const documentType =
                                                          'police clearance';
                                                      Get.to(
                                                          () =>
                                                              DocumentUploadScreen(
                                                                documentType:
                                                                    documentType,
                                                              ),
                                                          transition:
                                                              Transition.zoom);
                                                    },
                                                    child: const Text(
                                                        'Upload File'),
                                                  ),
                                                ),
                                                const SizedBox(width: 24),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('police clearance')
                                    .isNotEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('Police Clearance:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(width: 24),
                                                Expanded(
                                                  child: OutlinedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      final id =
                                                          policeClearanceDocuments[
                                                                      0][
                                                                  'document_id']
                                                              .toString();

                                                      final deleteDocumentsController =
                                                          Get.find<
                                                              DeleteDocumentsController>();
                                                      await deleteDocumentsController
                                                          .deleteDocument(id);

                                                      final uuid = Get.find<
                                                              UserInfoController>()
                                                          .userInfo['uuid'];

                                                      final documentsController =
                                                          Get.find<
                                                              DocumentsController>();
                                                      await documentsController
                                                          .fetchDocuments(uuid);
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      const documentType =
                                                          'Police Clearance';
                                                      final fileUrls =
                                                          policeClearanceDocuments[
                                                              0]['fileUrl'];
                                                      Get.to(
                                                          () => DocumentDetails(
                                                                documentType:
                                                                    documentType,
                                                                fileUrls:
                                                                    fileUrls,
                                                              ),
                                                          transition: Transition
                                                              .downToUp);
                                                    },
                                                    child: const Text('View'),
                                                  ),
                                                ),
                                                const SizedBox(width: 24),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('nbi clearance').isEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                                Text('NBI CLEARANCE',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(width: 24),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      const documentType =
                                                          'nbi clearance';
                                                      Get.to(
                                                          () =>
                                                              DocumentUploadScreen(
                                                                documentType:
                                                                    documentType,
                                                              ),
                                                          transition:
                                                              Transition.zoom);
                                                    },
                                                    child: const Text(
                                                        'Upload File'),
                                                  ),
                                                ),
                                                const SizedBox(width: 24),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                if (getDocumentsByType('nbi clearance')
                                    .isNotEmpty)
                                  Column(
                                    children: [
                                      CustomCard(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('NBI Clearance',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                                const Icon(
                                                  Icons.description_outlined,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(width: 24),
                                                Expanded(
                                                  child: OutlinedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      final id =
                                                          nbiClearanceDocuments[
                                                                      0][
                                                                  'document_id']
                                                              .toString();

                                                      final deleteDocumentsController =
                                                          Get.find<
                                                              DeleteDocumentsController>();
                                                      await deleteDocumentsController
                                                          .deleteDocument(id);

                                                      final uuid = Get.find<
                                                              UserInfoController>()
                                                          .userInfo['uuid'];

                                                      final documentsController =
                                                          Get.find<
                                                              DocumentsController>();
                                                      await documentsController
                                                          .fetchDocuments(uuid);
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                    ),
                                                    onPressed: () async {
                                                      const documentType =
                                                          'NBI Clearance';
                                                      final fileUrls =
                                                          nbiClearanceDocuments[
                                                              0]['fileUrl'];
                                                      Get.to(
                                                          () => DocumentDetails(
                                                                documentType:
                                                                    documentType,
                                                                fileUrls:
                                                                    fileUrls,
                                                              ),
                                                          transition: Transition
                                                              .downToUp);
                                                    },
                                                    child: const Text('View'),
                                                  ),
                                                ),
                                                const SizedBox(width: 24),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ];
}
