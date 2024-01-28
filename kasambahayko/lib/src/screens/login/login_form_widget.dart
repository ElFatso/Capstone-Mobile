import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/distance_calculator/location_service.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/email_input_field.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/password_input_field.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/constants/text_strings.dart';
import 'package:kasambahayko/src/controllers/bookings/employer_bookings_controller.dart';
import 'package:kasambahayko/src/controllers/bookings/worker_bookings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/job_listings_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/employer_profile_controller.dart';
import 'package:kasambahayko/src/controllers/search/worker_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/job_post_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/login_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/user_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_profile_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_valid_documents_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_screen.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_screen.dart';
import 'package:kasambahayko/src/screens/signup/additional_employer.dart';
import 'package:kasambahayko/src/screens/signup/additional_worker.dart';

class LoginForm extends StatelessWidget {
  final loginController = Get.find<LoginController>();

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
              controller: loginController.emailController,
            ),
            const SizedBox(
              height: formHeight - 20,
            ),
            PasswordInputField(
              controller: loginController.passwordController,
            ),
            const SizedBox(height: formHeight - 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  final bool isChecked = loginController.rememberMe.value;
                  return Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? newValue) {
                          if (newValue != null) {
                            loginController.rememberMe.value = newValue;
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
                      await loginController.signInWithEmailAndPassword();

                  if (loginResult['success']) {
                    var userInfo = loginResult['data'];
                    var distances =
                        await LocationService.fetchUserDistances(userInfo);
                    userInfo['distances'] = distances;

                    Get.find<UserInfoController>().userInfo.value = userInfo;

                    final userController = Get.find<UserController>();
                    userController
                        .fetchUserIdByUuid(userInfo['uuid'].toString());

                    final jobPostsController = Get.find<JobPostsController>();
                    jobPostsController.fetchJobPosts(userInfo['uuid']);

                    final filterController = Get.find<WorkerController>();
                    filterController.fetchWorkers();

                    final jobListController = Get.find<JobListingsController>();
                    jobListController.fetchJobListings(userInfo['uuid']);

                    final appliedJobsController =
                        Get.find<AppliedJobsController>();
                    appliedJobsController.fetchAppliedJobs(userInfo['uuid']);

                    if (userInfo['completedProfile'] == 'true') {
                      if (userInfo['userType'] == 'household employer') {
                        final employerProfileData =
                            await Get.find<EmployerProfileController>()
                                .fetchEmployerProfile(userInfo['uuid']);
                        Get.find<UserInfoController>().employerProfile.value =
                            employerProfileData!;
                        final employerBookingsController =
                            Get.find<EmployerBookingsController>();
                        await employerBookingsController.fetchEmployerBookings(
                            userController.userId.toString());
                        Get.to(() => const EmployerDashboardScreen(
                              initialPage: EmployerDashboardSections.home,
                            ));
                      } else if (userInfo['userType'] == 'domestic worker') {
                        final workerProfileData =
                            await Get.find<WorkerProfileController>()
                                .fetchWorkerProfile(userInfo['uuid']);
                        Get.find<UserInfoController>().workerProfile.value =
                            workerProfileData!;
                        final documentsController =
                            Get.find<DocumentsController>();
                        await documentsController
                            .fetchDocuments(userInfo['uuid']);
                        final workerBookingsController =
                            Get.find<WorkerBookingsController>();
                        await workerBookingsController.fetchWorkerBookings(
                            userController.userId.toString());
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
