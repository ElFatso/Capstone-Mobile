import 'package:get/get.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/additional_employer.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/additional_worker.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/signup_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/creation_applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/deletion_applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/job_listings_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/user_profile_image_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_background_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_experience_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_info_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_profile_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/user_contact_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/employer_household_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/employer_payment_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/employer_profile_controller.dart';
import 'package:kasambahayko/src/controllers/search/worker_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/create_post_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/delete_post_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/edit_post_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/job_post_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/login_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(RegistrationController());
    Get.put(CompleteEmployerProfileController());
    Get.put(CompleteWorkerProfileController());
    Get.put(UserInfoController());
    Get.put(UserContactController());
    Get.put(EmployerHouseholdInfoController());
    Get.put(EmployerPaymentInfoController());
    Get.put(EmployerProfileController());
    Get.put(WorkerProfileController());
    Get.put(ProfileImageUploadController());
    Get.put(WorkerInfoController());
    Get.put(WorkerExperienceController());
    Get.put(WorkerBackgroundController());
    Get.put(JobPostsController());
    Get.put(JobListingsController());
    Get.put(AppliedJobsController());
    Get.put(ApplyJobController());
    Get.put(DeleteApplicationController());
    Get.put(CreatePostController());
    Get.put(DeletePostController());
    Get.put(EditPostController());
    Get.put(WorkerController());
  }
}
