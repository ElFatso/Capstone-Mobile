import 'package:get/get.dart';
import 'package:kasambahayko/src/controllers/application_process/applicant_hiring_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_awaiting_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_passed_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_passed_delete_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_passed_select_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_schedule_complete_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_schedule_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_scheduled_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_schedule_delete_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_schedule_revert_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_screen_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_start_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_create_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_exist_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_update_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/step_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/step_reset_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/step_update_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/timeline_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/timeline_create_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/additional_employer.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/additional_worker.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/signup_controller.dart';
import 'package:kasambahayko/src/controllers/configurations_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/creation_applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/deletion_applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/job_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/progress_timeline_accept_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/progress_timeline_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/progress_timeline_decline_controller.dart';
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
import 'package:kasambahayko/src/controllers/user_controllers/worker_valid_documents_controller.dart';
import 'package:kasambahayko/src/controllers/user_controllers/worker_valid_documents_delete.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(RegistrationController());
    Get.put(ConfigurationsController());
    Get.put(JobApplicantsController());
    Get.put(StartApplicationController());
    Get.put(ScreeningResultsController());
    Get.put(ScheduledApplicantsController());
    Get.put(AwaitingApplicantsController());
    Get.put(InterviewScheduleController());
    Get.put(DeleteInterviewScheduleController());
    Get.put(CompleteInterviewScheduleController());
    Get.put(RevertInterviewScheduleController());
    Get.put(PassedInterviewController());
    Get.put(SelectPassedController());
    Get.put(DeletePassedController());
    Get.put(OfferController());
    Get.put(OfferExistController());
    Get.put(CreateOfferController());
    Get.put(UpdateOfferController());
    Get.put(TimelineEventController());
    Get.put(CreateTimelineEventController());
    Get.put(AcceptJobOfferController());
    Get.put(DeclineJobOfferController());
    Get.put(HiredApplicantController());
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
    Get.put(DocumentsController());
    Get.put(DeleteDocumentsController());
    Get.put(JobPostsController());
    Get.put(JobListingsController());
    Get.put(AppliedJobsController());
    Get.put(ApplyJobController());
    Get.put(DeleteApplicationController());
    Get.put(ProgressTimelineController());
    Get.put(CreatePostController());
    Get.put(DeletePostController());
    Get.put(EditPostController());
    Get.put(WorkerController());
    Get.put(StepController());
    Get.put(UpdateStepController());
    Get.put(ResetStepController());
  }
}
