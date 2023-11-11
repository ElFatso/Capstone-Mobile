import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/distance_calculator/location_service.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/email_input_field.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/password_input_field.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/constants/text_strings.dart';
import 'package:kasambahayko/src/controllers/job_listings/applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/job_listings_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/employer_profile_controller.dart';
import 'package:kasambahayko/src/controllers/search/worker_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/job_post_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/login_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_profile_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_screen.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_screen.dart';
import 'package:kasambahayko/src/screens/signup/additional_employer.dart';
import 'package:kasambahayko/src/screens/signup/additional_worker.dart';

class LoginForm extends StatelessWidget {
  final LoginController controller = Get.find();

  LoginForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmailInputField(
              controller: controller.emailController,
            ),
            const SizedBox(
              height: formHeight - 20,
            ),
            PasswordInputField(
              controller: controller.passwordController,
            ),
            const SizedBox(height: formHeight - 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  final bool isChecked = controller.rememberMe.value;
                  return Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? newValue) {
                          if (newValue != null) {
                            controller.rememberMe.value = newValue;
                          }
                        },
                      ),
                      const Text('Remember Me'),
                    ],
                  );
                }),
                TextButton(
                  onPressed: () {},
                  child: const Text(forgotPassword),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final loginResult =
                      await controller.signInWithEmailAndPassword();

                  if (loginResult['success']) {
                    var userInfo = loginResult['data'];
                    var distances =
                        await LocationService.fetchUserDistances(userInfo);
                    userInfo['distances'] = distances;
                    Get.find<UserInfoController>().userInfo.value = userInfo;
                    final jobPostsController = Get.find<JobPostsController>();
                    jobPostsController.fetchJobPosts(userInfo['uuid']);

                    final filterController = Get.find<WorkerController>();
                    filterController.fetchWorkers();

                    final jobListController = Get.find<JobListingsController>();
                    jobListController.fetchJobListings(userInfo['uuid']);

                    final appliedJobsController =
                        Get.find<AppliedJobsController>();
                    appliedJobsController.fetchAppliedJobs(userInfo['uuid']);

                    Get.find<UserInfoController>().userInfo;

                    if (userInfo['completedProfile'] == 'true') {
                      if (userInfo['userType'] == 'household employer') {
                        final employerProfileData =
                            await Get.find<EmployerProfileController>()
                                .fetchEmployerProfile(userInfo['uuid']);

                        Get.find<UserInfoController>().employerProfile.value =
                            employerProfileData!;

                        Get.to(() => const EmployerDashboardScreen(
                              initialPage: EmployerDashboardSections.home,
                            ));
                      } else if (userInfo['userType'] == 'domestic worker') {
                        final workerProfileData =
                            await Get.find<WorkerProfileController>()
                                .fetchWorkerProfile(userInfo['uuid']);
                        Get.find<UserInfoController>().workerProfile.value =
                            workerProfileData!;
                        Get.to(() => const WorkerDashboardScreen(
                              initialPage: WorkerDashboardSections.home,
                            ));
                      }
                    } else if (userInfo['completedProfile'] == 'false') {
                      if (userInfo['userType'] == 'household employer') {
                        Get.to(() => const EmployerAdditionalScreen());
                      } else if (userInfo['userType'] == 'domestic worker') {
                        Get.to(() => const WorkerAdditionalScreen());
                      }
                    }
                  } else {}
                },
                child: Text(login.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
