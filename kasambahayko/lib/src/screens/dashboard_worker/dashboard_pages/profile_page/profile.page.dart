import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/single_item_dropdown.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/user_contact_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_background_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_experience_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_info_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/profile_page/profile_picker.dart';
import 'package:multiselect/multiselect.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String email = '';
  String phone = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isContactInfoEdit = false;

  final List<String> availableCare = [
    'Child Care',
    'Elder Care',
    'Pet Care',
    'House Services'
  ];

  List<String?> selectedServices = [];
  String bio = '';
  String availability = '';
  TextEditingController bioController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();
  bool isWorkerInfoEdit = false;

  String experiences = '';
  double hourlyRate = 1.0;
  String skills = '';
  TextEditingController experiencesController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  bool isWorkerExperiencesEdit = false;

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

  List<String?> selectedLanguages = [];
  List<String?> selectedCertifications = [];
  String? selectedEducationLevel = 'Elementary';
  final List<String> availableEducationLevel = [
    'Elementary',
    'High School',
    'College',
    'Vocational',
    'Post Graduate',
  ];
  bool isWorkerBackgroundEdit = false;

  @override
  void initState() {
    super.initState();
    final userInfo = Get.find<UserInfoController>().userInfo;
    emailController.text = userInfo['email'].toString();
    phoneController.text = userInfo['phone'].toString();
    email = userInfo['email'].toString();
    phone = userInfo['phone'].toString();

    final workerProfile = Get.find<UserInfoController>().workerProfile;
    bioController.text = workerProfile['bio'].toString();
    availabilityController.text = workerProfile['availability'].toString();
    bio = workerProfile['bio'].toString();
    availability = workerProfile['availability'].toString();
    List<dynamic> servicesData = workerProfile['servicesOffered'];

    selectedServices = servicesData
        .map((item) {
          if (item is Map<String, dynamic> &&
              item.containsKey("service_name")) {
            return item["service_name"].toString();
          }
          return null;
        })
        .where((item) => item != null)
        .toList();

    log(selectedServices.toString());

    experiencesController.text = workerProfile['work_experience'].toString();
    hourlyRateController.text = workerProfile['hourly_rate'].toString();
    experiences = workerProfile['work_experience'].toString();
    hourlyRate = double.parse(workerProfile['hourly_rate']);
    String skillsData = workerProfile['skills'].toString();
    List<String> listSkills =
        skillsData.split(',').map((s) => s.trim()).toList();
    skills = listSkills.join(', ');
    skillsController.text = listSkills.join(', ');

    selectedEducationLevel = workerProfile['education'].toString();
    List<dynamic> languagesData = workerProfile['languages'];

    selectedLanguages = languagesData
        .map((item) {
          if (item is Map<String, dynamic> && item.containsKey("name")) {
            return item["name"].toString();
          }
          return null;
        })
        .where((item) => item != null)
        .toList();

    log(selectedLanguages.toString());

    List<dynamic> certificationsData = workerProfile['certifications'];

    selectedCertifications = certificationsData
        .map((item) {
          if (item is Map<String, dynamic> && item.containsKey("name")) {
            return item["name"].toString();
          }
          return null;
        })
        .where((item) => item != null)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Get.find<UserInfoController>().userInfo;
    final imageUrl = userInfo['imageUrl'].toString();
    final firstName = userInfo['firstName'].toString();
    final lastName = userInfo['lastName'].toString();
    final city = userInfo['city'].toString();
    final barangay = userInfo['barangay'].toString();
    final street = userInfo['street'].toString();
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
    String skillsData = skills.replaceAll(', ', ',');
    List<String> originalSkills = skillsData.split(', ').toList();
    log(originalSkills.toString());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultpadding),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color(0xFFFAFAFA),
                      child: ClipOval(
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ImageSelectionScreen(),
                              transition: Transition.zoom);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFAFAFA),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 24,
                            color: secondarycolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '$firstName $lastName',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$city, $barangay, $street',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                ExpansionTile(
                  title: const Text("Contact Information",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  children: <Widget>[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        hintText: 'Email Address',
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      style: Theme.of(context).textTheme.bodyMedium,
                      enabled: isContactInfoEdit,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        hintText: 'Phone Number',
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      style: Theme.of(context).textTheme.bodyMedium,
                      enabled: isContactInfoEdit,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.all(16)),
                            onPressed: () {
                              setState(() {
                                isContactInfoEdit = !isContactInfoEdit;
                              });
                            },
                            child: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.all(16)),
                            onPressed: () {
                              final userContactController =
                                  Get.find<UserContactController>();
                              userContactController.updateUserContactInfo(
                                  userInfo['uuid'].toString(), phone, email);

                              final userInfoController =
                                  Get.find<UserInfoController>();
                              userInfoController.userInfo['phone'] = phone;
                              userInfoController.userInfo['email'] = email;
                            },
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                ExpansionTile(
                  title: const Text("Worker Information",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  children: <Widget>[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: bioController,
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
                      enabled: isWorkerInfoEdit,
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
                      enabled: isWorkerInfoEdit,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: availabilityController,
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
                      enabled: isWorkerInfoEdit,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.all(16)),
                            onPressed: () {
                              setState(() {
                                isWorkerInfoEdit = !isWorkerInfoEdit;
                              });
                            },
                            child: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.all(16)),
                            onPressed: () {
                              final workerInfoController =
                                  Get.find<WorkerInfoController>();
                              workerInfoController.updateWorkerInfo(
                                  userInfo['uuid'].toString(),
                                  bio,
                                  services,
                                  availability);
                              final userInfoController =
                                  Get.find<UserInfoController>();
                              userInfoController.workerProfile['bio'] = bio;
                              userInfoController
                                  .workerProfile['servicesOffered'] = services;
                              userInfoController.workerProfile['availability'] =
                                  availability;
                              setState(() {
                                isWorkerInfoEdit = !isWorkerInfoEdit;
                              });
                            },
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                ExpansionTile(
                  title: const Text("Experiences",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  children: <Widget>[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: experiencesController,
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
                      enabled: isWorkerExperiencesEdit,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: hourlyRateController,
                      readOnly: true,
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
                                  hourlyRateController.text =
                                      hourlyRate.toString();
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onPressed: () {
                                setState(() {
                                  hourlyRate -= 10.0;
                                  hourlyRateController.text =
                                      hourlyRate.toString();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      enabled: isWorkerExperiencesEdit,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: skillsController,
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
                      enabled: isWorkerExperiencesEdit,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.all(16)),
                            onPressed: () {
                              setState(() {
                                isWorkerExperiencesEdit =
                                    !isWorkerExperiencesEdit;
                              });
                            },
                            child: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.all(16)),
                            onPressed: () {
                              final workerExperienceController =
                                  Get.find<WorkerExperienceController>();
                              workerExperienceController
                                  .updateWorkerExperienceInfo(
                                      userInfo['uuid'].toString(),
                                      experiences,
                                      hourlyRate,
                                      originalSkills);
                              final userInfoController =
                                  Get.find<UserInfoController>();
                              userInfoController
                                      .workerProfile['work_experience'] =
                                  experiences;
                              userInfoController.workerProfile['hourly_rate'] =
                                  hourlyRate.toString();
                              userInfoController.workerProfile['skills'] =
                                  skills;
                              setState(() {
                                isWorkerExperiencesEdit =
                                    !isWorkerExperiencesEdit;
                              });
                            },
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                ExpansionTile(
                  title: const Text("Background",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  children: <Widget>[
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
                      enabled: isWorkerBackgroundEdit,
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
                      enabled: isWorkerBackgroundEdit,
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
                      enabled: isWorkerBackgroundEdit,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.all(16)),
                            onPressed: () {
                              setState(() {
                                isWorkerBackgroundEdit =
                                    !isWorkerBackgroundEdit;
                              });
                            },
                            child: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.all(16)),
                            onPressed: () {
                              final workerBackgroundController =
                                  Get.find<WorkerBackgroundController>();
                              workerBackgroundController
                                  .updateWorkerBackgroundInfo(
                                      userInfo['uuid'].toString(),
                                      selectedEducationLevel!,
                                      certifications,
                                      languages);
                              final userInfoController =
                                  Get.find<UserInfoController>();
                              userInfoController.workerProfile['education'] =
                                  selectedEducationLevel;
                              userInfoController.workerProfile['languages'] =
                                  languages;
                              userInfoController
                                      .workerProfile['certifications'] =
                                  certifications;
                              setState(() {
                                isWorkerBackgroundEdit =
                                    !isWorkerBackgroundEdit;
                              });
                            },
                            child: const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                const ExpansionTile(
                    title: Text("Documents",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )),
                    children: <Widget>[
                      SizedBox(height: 12),
                      SizedBox(height: 16),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
