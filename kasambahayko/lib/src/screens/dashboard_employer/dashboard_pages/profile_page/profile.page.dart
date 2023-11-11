import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/boolean_multiselect_input_field.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/payment_frequency_input_field.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/user_contact_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/employer_household_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/employer_payment_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/profile_page/profile_picker.dart';
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

  List<int> selectedPets = [];
  String size = '';
  String requirements = '';
  TextEditingController sizeController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  bool isHouseholdInfoEdit = false;

  final List<String> availablePaymentMethods = [
    'Direct Deposit',
    'Paypal',
    'Gcash',
    'Cash',
    'Paymaya',
  ];

  List<String?> selectedPaymentMethods = [];
  String? selectedPaymentFrequency;
  bool isPaymentInfoEdit = false;

  @override
  void initState() {
    super.initState();
    final userInfo = Get.find<UserInfoController>().userInfo;
    emailController.text = userInfo['email'].toString();
    phoneController.text = userInfo['phone'].toString();
    email = userInfo['email'].toString();
    phone = userInfo['phone'].toString();
    final profileInfo = Get.find<UserInfoController>().employerProfile;
    sizeController.text = profileInfo['householdSize'].toString();
    requirementsController.text = profileInfo['specificNeeds'].toString();
    size = profileInfo['householdSize'].toString();
    requirements = profileInfo['specificNeeds'].toString();
    selectedPaymentFrequency = profileInfo['paymentFrequency'].toString();
    List<dynamic> paymentMethodsData = profileInfo['paymentMethods'];

    log(paymentMethodsData.toString());

    selectedPaymentMethods = paymentMethodsData
        .map((item) {
          if (item is Map<String, dynamic> && item.containsKey("name")) {
            return item["name"].toString();
          }
          return null;
        })
        .where((item) => item != null)
        .toList();

    log(selectedPaymentMethods.toString());

    Map<String, dynamic> petsData = profileInfo['pets'];

    selectedPets = petsData.values.cast<int>().toList();
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
    Map<String, dynamic> pets = Map.fromIterables(printingPets, selectedPets);
    List<Map<String, dynamic>> paymentMethods =
        selectedPaymentMethods.map((item) {
      return {"name": item};
    }).toList();

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
                            color: primarycolor,
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
                              setState(() {
                                isContactInfoEdit = !isContactInfoEdit;
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
                  title: const Text("Household Information",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  children: <Widget>[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: sizeController,
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
                      enabled: isHouseholdInfoEdit,
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
                      enabled: isHouseholdInfoEdit,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: requirementsController,
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
                      enabled: isHouseholdInfoEdit,
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
                                isHouseholdInfoEdit = !isHouseholdInfoEdit;
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
                              final userHouseholdController =
                                  Get.find<EmployerHouseholdInfoController>();
                              userHouseholdController.updateHouseholdInfo(
                                  userInfo['uuid'].toString(),
                                  size,
                                  pets,
                                  requirements);
                              final userInfoController =
                                  Get.find<UserInfoController>();
                              userInfoController
                                  .employerProfile['householdSize'] = size;
                              userInfoController.employerProfile['pets'] = pets;
                              userInfoController
                                      .employerProfile['specificNeeds'] =
                                  requirements;
                              setState(() {
                                isHouseholdInfoEdit = !isHouseholdInfoEdit;
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
                  title: const Text("Payment Information",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
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
                                selectedPaymentMethods =
                                    selectedItems.cast<String>();
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Select Payment Methods",
                              labelStyle:
                                  Theme.of(context).textTheme.bodyMedium,
                              border: const OutlineInputBorder(),
                            ),
                            enabled: isPaymentInfoEdit,
                          ),
                          const SizedBox(height: 12),
                          Text("Payment Frequency",
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 12),
                          PaymentFrequencyWidget(
                            selectedFrequency: stringToPaymentFrequency(
                                selectedPaymentFrequency),
                            onChanged: (value) {
                              setState(() {
                                selectedPaymentFrequency =
                                    paymentFrequencyToString(value);
                              });
                            },
                            enabled: isPaymentInfoEdit,
                          ),
                        ],
                      ),
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
                                isPaymentInfoEdit = !isPaymentInfoEdit;
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
                              final userPaymentController =
                                  Get.find<EmployerPaymentInfoController>();
                              userPaymentController.updatePaymentInfo(
                                  userInfo['uuid'].toString(),
                                  paymentMethods,
                                  selectedPaymentFrequency!);
                              final userInfoController =
                                  Get.find<UserInfoController>();
                              userInfoController
                                      .employerProfile['paymentMethods'] =
                                  paymentMethods;
                              userInfoController
                                      .employerProfile['paymentFrequency'] =
                                  selectedPaymentFrequency;

                              setState(() {
                                isPaymentInfoEdit = !isPaymentInfoEdit;
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
