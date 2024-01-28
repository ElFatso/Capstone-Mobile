import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/common_widgets/card/custom_card.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/highlight.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/status_highlight.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/single_item_dropdown.dart';
import 'package:kasambahayko/src/common_widgets/picker/date_picker/date_schedule_picker.dart';
import 'package:kasambahayko/src/common_widgets/picker/time_picker/time_schedule_picker.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/application_process/applicant_hiring_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_awaiting_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_passed_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_passed_delete_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_schedule_complete_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_schedule_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_scheduled_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_schedule_delete_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_schedule_revert_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_screen_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_start_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_create_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_update_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/step_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/step_reset_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/step_update_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/timeline_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/timeline_create_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/routing/api/api_constants.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/postings/applicant_change.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/postings/applicant_details.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/postings/applicant_filter.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/postings/offer_history.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';
import 'package:multiselect/multiselect.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({Key? key}) : super(key: key);

  @override
  ApplicationsPageState createState() => ApplicationsPageState();
}

class ApplicationsPageState extends State<ApplicationsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<String> stages = [
    "application",
    "screening",
    "interview",
    "offer",
    "hired"
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: stages.length, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });

    final stepController = Get.find<StepController>();
    String initialStage = stepController.currentStep.value;

    setInitialTab(initialStage);
  }

  void setInitialTab(String stage) {
    int index = stages.indexOf(stage);
    if (index != -1) {
      tabController.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        SizedBox(
          height: 8,
          child: LinearProgressIndicator(
            value: (tabController.index + 1) / tabController.length,
            backgroundColor: greycolor,
            valueColor: const AlwaysStoppedAnimation<Color>(primarycolor),
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: stages.map((stage) {
              return buildTabPage(stage);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildTabPage(String stage) {
    switch (stage) {
      case "application":
        return StepOnePage(
          tabController: tabController,
        );
      case "screening":
        return StepTwoPage(tabController: tabController);
      case "interview":
        return StepThreePage(tabController: tabController);
      case "offer":
        return StepFourPage(tabController: tabController);
      case "hired":
        return StepFivePage(tabController: tabController);
      default:
        throw Exception("Invalid stage: $stage");
    }
  }
}

class StepOnePage extends StatelessWidget {
  final TabController tabController;
  const StepOnePage({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobApplicantsController>(
      init: JobApplicantsController(),
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.error.isNotEmpty) {
          return Center(child: Text('Error: ${controller.error}'));
        } else {}
        return Padding(
          padding: const EdgeInsets.only(
              top: 12,
              bottom: defaultpadding,
              left: defaultpadding,
              right: defaultpadding),
          child: ListView(
            children: [
              Text(
                'Applications',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.totalApplicants.length,
                    itemBuilder: (context, index) {
                      final applicant = controller.totalApplicants[index];
                      final firstName = applicant['information']['first_name'];
                      final lastName = applicant['information']['last_name'];
                      final profileUrl =
                          applicant['information']['profile_url'];
                      final city =
                          applicant['information']['city_municipality'];
                      final barangay = applicant['information']['barangay'];
                      final verification =
                          applicant['information']['is_verified'];
                      final bio = applicant['information']['bio'];
                      final availability =
                          applicant['information']['availability'];
                      final distance =
                          applicant['information']['distance'].toString();
                      final experience =
                          applicant['information']['work_experience'];
                      final rate = applicant['information']['hourly_rate'];
                      final servicesList = applicant['information']['services'];
                      final languagesList =
                          applicant['information']['languages'];
                      final documents = applicant['information']['documents'];
                      final appDate = applicant['application_date'];

                      final date = DateTime.parse(appDate);
                      final formattedAppDate =
                          DateFormat('EEEE, MM-dd-yyyy').format(date);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: CustomCard(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.network(
                                          profileUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '$firstName $lastName',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (verification == 'true')
                                            const Highlight(
                                              label: 'Badges:',
                                              highlightColor: greencolor,
                                              text: 'Verified',
                                            ),
                                          if (verification == 'false')
                                            const Highlight(
                                              label: 'Badges:',
                                              highlightColor: yellowcolor,
                                              text: 'Unverified',
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                color: greycolor,
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    const Icon(
                                      Icons.star_border,
                                      size: 32.0,
                                    ),
                                ],
                              ),
                              const Divider(
                                color: greycolor,
                                thickness: 1,
                              ),
                              Text(
                                '$barangay, $city',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formattedAppDate,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                ),
                                onPressed: () {
                                  Get.to(
                                      () => ApplicantDetailsScreen(
                                            profileUrl: profileUrl,
                                            lastName: lastName,
                                            firstName: firstName,
                                            rate: rate,
                                            city: city,
                                            verified: verification,
                                            bio: bio,
                                            availability: availability,
                                            distance: distance,
                                            experience: experience,
                                            servicesList: servicesList,
                                            languagesList: languagesList,
                                            documents: documents,
                                          ),
                                      transition: Transition.rightToLeft);
                                },
                                child: const Text('View Profile'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: () async {
                        final applicantsController =
                            Get.find<JobApplicantsController>();
                        final jobId = applicantsController.totalApplicants[0]
                                ['job_id']
                            .toString();
                        final startApplicationController =
                            Get.find<StartApplicationController>();
                        startApplicationController.startJobApplication(jobId);
                        tabController.animateTo(1);
                      },
                      child: const Text('START SELECTION'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class StepTwoPage extends StatelessWidget {
  final TabController tabController;
  const StepTwoPage({Key? key, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobApplicantsController>(
      init: JobApplicantsController(),
      builder: (jobApplicantsController) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 12,
              bottom: defaultpadding,
              left: defaultpadding,
              right: defaultpadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Screening Process',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                CustomCard(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: () {
                        Get.to(
                          () => ApplicantsFilter(
                            top: jobApplicantsController.topCount,
                          ),
                          transition: Transition.upToDown,
                        );
                      },
                      child: const Text('Filter Applicants'),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ExpansionTile(
                  title: Text(
                    'Qualified Applicants',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  children: [
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: jobApplicantsController
                            .filteredJobApplicants.length,
                        itemBuilder: (context, index) {
                          final passed = jobApplicantsController
                              .filteredJobApplicants[index];

                          final applicantIndex = jobApplicantsController
                              .totalApplicants
                              .indexWhere(
                            (applicant) =>
                                applicant['application_id'] ==
                                passed['application_id'],
                          );

                          if (applicantIndex != -1) {
                            final applicant = jobApplicantsController
                                .totalApplicants[applicantIndex];
                            final firstName =
                                applicant['information']['first_name'];
                            final lastName =
                                applicant['information']['last_name'];
                            final profileUrl =
                                applicant['information']['profile_url'];
                            final city =
                                applicant['information']['city_municipality'];
                            final barangay =
                                applicant['information']['barangay'];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: CustomCard(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child: ClipOval(
                                            child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Image.network(
                                                profileUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$firstName $lastName',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              '$barangay, $city',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      onPressed: () {
                                        jobApplicantsController
                                            .transferToApplicant(index);
                                      },
                                      child:
                                          const Text('Remove from Shortlist'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('Applicants',
                      style: Theme.of(context).textTheme.titleSmall),
                  children: [
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: jobApplicantsController.jobApplicants.length,
                        itemBuilder: (context, index) {
                          final failed =
                              jobApplicantsController.jobApplicants[index];

                          final applicantIndex = jobApplicantsController
                              .totalApplicants
                              .indexWhere(
                            (applicant) =>
                                applicant['application_id'] ==
                                failed['application_id'],
                          );

                          if (applicantIndex != -1) {
                            final applicant = jobApplicantsController
                                .totalApplicants[applicantIndex];
                            final firstName =
                                applicant['information']['first_name'];
                            final lastName =
                                applicant['information']['last_name'];
                            final profileUrl =
                                applicant['information']['profile_url'];
                            final city =
                                applicant['information']['city_municipality'];
                            final barangay =
                                applicant['information']['barangay'];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: CustomCard(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child: ClipOval(
                                            child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Image.network(
                                                profileUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$firstName $lastName',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              '$barangay, $city',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.all(12),
                                      ),
                                      onPressed: () {
                                        jobApplicantsController
                                            .transferToQApplicant(index);
                                      },
                                      child: const Text('Add to Shortlist'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () async {
                          final applicantsController =
                              Get.find<JobApplicantsController>();
                          final jobId = applicantsController.totalApplicants[0]
                                  ['job_id']
                              .toString();
                          final updateStepController =
                              Get.find<UpdateStepController>();
                          await updateStepController.updateApplicationStage(
                              jobId, 'application');
                          tabController.animateTo(0);
                        },
                        child: const Text('BACK'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () async {
                          final awaitingApplicantsController =
                              Get.find<AwaitingApplicantsController>();
                          final applicantsController =
                              Get.find<JobApplicantsController>();
                          final jobId = applicantsController.totalApplicants[0]
                                  ['job_id']
                              .toString();
                          List<Map<String, dynamic>> formattedScreeningResults =
                              [
                            ...jobApplicantsController.filteredJobApplicants
                                .map((applicant) => {
                                      'application_id':
                                          applicant['application_id'],
                                      'result': 'passed',
                                    }),
                            ...jobApplicantsController.jobApplicants
                                .map((applicant) => {
                                      'application_id':
                                          applicant['application_id'],
                                      'result': 'failed',
                                    }),
                          ];
                          final screeningResultsController =
                              Get.find<ScreeningResultsController>();
                          await screeningResultsController
                              .updateScreeningResults(
                                  jobId, formattedScreeningResults);

                          await awaitingApplicantsController
                              .fetchScreeningResults(jobId);

                          final updateStepController =
                              Get.find<UpdateStepController>();
                          await updateStepController.updateApplicationStage(
                              jobId, 'interview');
                          tabController.animateTo(2);
                        },
                        child: const Text('CONTINUE'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StepThreePage extends StatelessWidget {
  final TabController tabController;
  const StepThreePage({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobApplicantsController>(
      init: JobApplicantsController(),
      builder: (jobApplicantsController) {
        jobApplicantsController.totalApplicants;

        return GetBuilder<ScheduledApplicantsController>(
          init: ScheduledApplicantsController(),
          builder: (scheduledApplicantsController) {
            scheduledApplicantsController.allInterviews;

            return Padding(
              padding: const EdgeInsets.only(
                  top: 12,
                  bottom: defaultpadding,
                  left: defaultpadding,
                  right: defaultpadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Assessment',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    CompletedInterviewsExpansionTile(
                        tabController: tabController,
                        totalApplicants:
                            jobApplicantsController.totalApplicants),
                    ScheduledInterviewsExpansionTile(
                        tabController: tabController,
                        totalApplicants:
                            jobApplicantsController.totalApplicants),
                    AwaitingScheduleExpansionTile(
                        tabController: tabController,
                        totalApplicants:
                            jobApplicantsController.totalApplicants,
                        allInterviews:
                            scheduledApplicantsController.allInterviews),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                            ),
                            onPressed: () async {
                              final applicantsController =
                                  Get.find<JobApplicantsController>();
                              final jobId = applicantsController
                                  .totalApplicants[0]['job_id']
                                  .toString();
                              final updateStepController =
                                  Get.find<UpdateStepController>();
                              await updateStepController.updateApplicationStage(
                                  jobId, 'screening');
                              final resetStepController =
                                  Get.find<ResetStepController>();
                              await resetStepController
                                  .resetCurrentStage(jobId);
                              final jobApplicantsController =
                                  Get.find<JobApplicantsController>();
                              jobApplicantsController.fetchJobApplicants(jobId);
                              tabController.animateTo(1);
                            },
                            child: const Text('BACK'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                            ),
                            onPressed: () async {
                              final applicantsController =
                                  Get.find<JobApplicantsController>();
                              final jobId = applicantsController
                                  .totalApplicants[0]['job_id']
                                  .toString();
                              final updateStepController =
                                  Get.find<UpdateStepController>();
                              await updateStepController.updateApplicationStage(
                                  jobId, 'offer');
                              tabController.animateTo(3);
                            },
                            child: const Text('CONTINUE'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CompletedInterviewsExpansionTile extends StatelessWidget {
  final TabController tabController;
  final RxList<Map<String, dynamic>> totalApplicants;
  const CompletedInterviewsExpansionTile(
      {Key? key, required this.tabController, required this.totalApplicants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduledApplicantsController>(
      init: ScheduledApplicantsController(),
      builder: (controller) {
        return ExpansionTile(
          title: Text('Completed Interviews',
              style: Theme.of(context).textTheme.titleSmall),
          children: [
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.completedInterviews.length,
                itemBuilder: (context, index) {
                  final scheduled = controller.completedInterviews[index];
                  final scheduledTime = scheduled['scheduled_time'];
                  final scheduledDate = scheduled['scheduled_date'];
                  final link = scheduled['interview_link'];
                  Uri url = Uri.parse(link);

                  final date = DateTime.parse(scheduledDate);
                  final formattedAppDate =
                      DateFormat('EEEE, MM-dd-yyyy').format(date);

                  final applicantIndex = totalApplicants.indexWhere(
                    (applicant) =>
                        applicant['application_id'] ==
                        scheduled['application_id'],
                  );

                  if (applicantIndex != -1) {
                    final applicant = totalApplicants[applicantIndex];
                    final jobId = applicant['job_id'].toString();
                    final appId = applicant['application_id'].toString();
                    final firstName = applicant['information']['first_name'];
                    final lastName = applicant['information']['last_name'];
                    final profileUrl = applicant['information']['profile_url'];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: CustomCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                        profileUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$firstName $lastName',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '$formattedAppDate at $scheduledTime',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              color: greycolor,
                              thickness: 1,
                            ),
                            Text(
                              url.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Divider(
                              color: greycolor,
                              thickness: 1,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: redcolor,
                                side: const BorderSide(color: redcolor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(12),
                              ),
                              onPressed: () async {
                                final revertInterviewScheduleController = Get
                                    .find<RevertInterviewScheduleController>();
                                await revertInterviewScheduleController
                                    .revertInterviewSchedule(jobId, appId);

                                final scheduledApplicantsController =
                                    Get.find<ScheduledApplicantsController>();
                                scheduledApplicantsController
                                    .fetchInterviewSchedules(jobId);
                              },
                              child: const Text('Back to Scheduling'),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class ScheduledInterviewsExpansionTile extends StatelessWidget {
  final TabController tabController;
  final RxList<Map<String, dynamic>> totalApplicants;
  const ScheduledInterviewsExpansionTile(
      {Key? key, required this.tabController, required this.totalApplicants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduledApplicantsController>(
      init: ScheduledApplicantsController(),
      builder: (controller) {
        return ExpansionTile(
          title: Text('Scheduled Interviews',
              style: Theme.of(context).textTheme.titleSmall),
          children: [
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.scheduledInterviews.length,
                itemBuilder: (context, index) {
                  final userInfo = Get.find<UserInfoController>().userInfo;
                  final first = userInfo['firstName'].toString();
                  final last = userInfo['lastName'].toString();
                  final uuid = userInfo['uuid'].toString();

                  final scheduled = controller.scheduledInterviews[index];
                  final scheduledTime = scheduled['scheduled_time'];
                  final scheduledDate = scheduled['scheduled_date'];
                  final link = scheduled['interview_link'];

                  final linkParts = link.split('/');
                  final callId = linkParts.last;

                  final date = DateTime.parse(scheduledDate);
                  final formattedAppDate =
                      DateFormat('EEEE, MM-dd-yyyy').format(date);

                  final applicantIndex = totalApplicants.indexWhere(
                    (applicant) =>
                        applicant['application_id'] ==
                        scheduled['application_id'],
                  );

                  if (applicantIndex != -1) {
                    final applicant = totalApplicants[applicantIndex];
                    final jobId = applicant['job_id'].toString();
                    final appId = applicant['application_id'].toString();
                    final firstName = applicant['information']['first_name'];
                    final lastName = applicant['information']['last_name'];
                    final profileUrl = applicant['information']['profile_url'];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: CustomCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                        profileUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$firstName $lastName',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '$formattedAppDate at $scheduledTime',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              color: greycolor,
                              thickness: 1,
                            ),
                            Text.rich(
                              TextSpan(
                                text: link,
                                style: const TextStyle(
                                  color: bluecolor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(
                                      () => ZegoUIKitPrebuiltCall(
                                        appID: ApiConstants.appId,
                                        appSign: ApiConstants.appSign,
                                        userID: uuid,
                                        userName: '$first $last',
                                        callID: callId,
                                        config: ZegoUIKitPrebuiltCallConfig
                                            .oneOnOneVideoCall(),
                                      ),
                                      transition: Transition.fade,
                                    );
                                  },
                              ),
                            ),
                            const Divider(
                              color: greycolor,
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 16),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: redcolor,
                                      side: const BorderSide(color: redcolor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(12),
                                    ),
                                    onPressed: () async {
                                      final deleteInterviewScheduleController =
                                          Get.find<
                                              DeleteInterviewScheduleController>();
                                      await deleteInterviewScheduleController
                                          .deleteInterviewResult(jobId, appId);

                                      final awaitingApplicantsController = Get
                                          .find<AwaitingApplicantsController>();
                                      awaitingApplicantsController
                                          .fetchScreeningResults(jobId);

                                      final scheduledApplicantsController =
                                          Get.find<
                                              ScheduledApplicantsController>();
                                      scheduledApplicantsController
                                          .fetchInterviewSchedules(jobId);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(12),
                                    ),
                                    onPressed: () async {
                                      final completeInterviewScheduleController =
                                          Get.find<
                                              CompleteInterviewScheduleController>();
                                      await completeInterviewScheduleController
                                          .completeInterview(jobId, appId);

                                      final scheduledApplicantsController =
                                          Get.find<
                                              ScheduledApplicantsController>();
                                      scheduledApplicantsController
                                          .fetchInterviewSchedules(jobId);
                                    },
                                    child: const Text('Complete'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class AwaitingScheduleExpansionTile extends StatefulWidget {
  final TabController tabController;
  final RxList<Map<String, dynamic>> totalApplicants;
  final RxList<Map<String, dynamic>> allInterviews;
  const AwaitingScheduleExpansionTile(
      {Key? key,
      required this.tabController,
      required this.totalApplicants,
      required this.allInterviews})
      : super(key: key);

  @override
  State<AwaitingScheduleExpansionTile> createState() =>
      AwaitingScheduleExpansionTileState();
}

class AwaitingScheduleExpansionTileState
    extends State<AwaitingScheduleExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AwaitingApplicantsController>(
      init: AwaitingApplicantsController(),
      builder: (controller) {
        return ExpansionTile(
          title: Text('Awaiting Schedule',
              style: Theme.of(context).textTheme.titleSmall),
          children: [
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.screeningPassed.length,
                itemBuilder: (context, index) {
                  List<Map<String, dynamic>> filteredResults = controller
                      .screeningPassed
                      .where((result) => !widget.allInterviews.any(
                          (scheduled) =>
                              scheduled['application_id'] ==
                              result['application_id']))
                      .toList();

                  if (index < filteredResults.length) {
                    final applicantIndex = widget.totalApplicants.indexWhere(
                      (applicant) =>
                          applicant['application_id'] ==
                          filteredResults[index]['application_id'],
                    );

                    if (applicantIndex != -1) {
                      final applicant = widget.totalApplicants[applicantIndex];
                      final jobId = applicant['job_id'].toString();
                      final appId = applicant['application_id'].toString();
                      final firstName = applicant['information']['first_name'];
                      final lastName = applicant['information']['last_name'];
                      final profileUrl =
                          applicant['information']['profile_url'];
                      final email = applicant['information']['email'];

                      DateTime scheduleDate = DateTime.now();
                      DateTime scheduleTime = DateTime.now();
                      String interviewLink = '';

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: CustomCard(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.network(
                                          profileUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '$firstName $lastName',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        email,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                ),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: '',
                                    titleStyle:
                                        Theme.of(context).textTheme.titleSmall,
                                    content: Theme(
                                      data: EmployerTheme.theme,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8, left: 8),
                                        child: Column(
                                          children: [
                                            SingleDatePickerWidget(
                                              selectedScheduleDate:
                                                  scheduleDate,
                                              onScheduleDateSelected: (date) {
                                                setState(() {
                                                  scheduleDate = date;
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            SingleTimePickerWidget(
                                              selectedScheduleTime:
                                                  scheduleTime,
                                              onScheduleTimeSelected: (time) {
                                                setState(() {
                                                  scheduleTime = time;
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            TextFormField(
                                              minLines: 1,
                                              maxLines: null,
                                              decoration: InputDecoration(
                                                labelText: "Interview Link",
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                border:
                                                    const OutlineInputBorder(),
                                                suffixIcon:
                                                    const Icon(Icons.link),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  interviewLink = value;
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 8),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(12),
                                              ),
                                              onPressed: () async {
                                                Map<String, dynamic>
                                                    interviewResult = {
                                                  'date':
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(scheduleDate),
                                                  'time': DateFormat(
                                                          'yyyy-MM-ddTHH:mm')
                                                      .format(scheduleTime),
                                                  'link': interviewLink,
                                                };

                                                final interviewScheduleController =
                                                    Get.find<
                                                        InterviewScheduleController>();
                                                await interviewScheduleController
                                                    .scheduleInterview(jobId,
                                                        appId, interviewResult);

                                                final awaitingApplicantsController =
                                                    Get.find<
                                                        AwaitingApplicantsController>();
                                                awaitingApplicantsController
                                                    .fetchScreeningResults(
                                                        jobId);

                                                final scheduledApplicantsController =
                                                    Get.find<
                                                        ScheduledApplicantsController>();
                                                scheduledApplicantsController
                                                    .fetchInterviewSchedules(
                                                        jobId);

                                                Get.back();
                                              },
                                              child: const Text('Schedule'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Set Date and Time'),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }
                  return null;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class StepFourPage extends StatefulWidget {
  final TabController tabController;
  const StepFourPage({Key? key, required this.tabController}) : super(key: key);

  @override
  State<StepFourPage> createState() => StepFourPageState();
}

class StepFourPageState extends State<StepFourPage> {
  String proposedSalary = '';
  TextEditingController proposedSalaryController = TextEditingController();
  List<String?> selectedBenefits = [];
  final List<String> availableBenefits = [
    'Daily Meals',
    '13th Month Pay',
    'Annual Leave',
    'Sick Leave',
    'Birthday Leave',
    'Transportation Allowance',
    'Insurance Coverage',
    'Performance Bonus',
    'Educational Assistance',
    'Retirement Benefits',
  ];
  String? selectedPaymentFrequency = 'Daily';
  final List<String> availablePaymentFrequency = [
    'Daily',
    'Weekly',
    'Semi-Monthly',
    'Monthly',
  ];
  String? selectedDeadline = '1 day';
  final List<String> availableDeadline = [
    '1 day',
    '2 days',
    '3 days',
    '4 days',
    '5 days',
    '6 days',
    '7 days',
  ];
  String? status;

  @override
  Widget build(BuildContext context) {
    String? deadline = selectedDeadline == '1 day'
        ? selectedDeadline?.replaceAll(' day', '')
        : selectedDeadline?.replaceAll(' days', '');

    return GetBuilder<PassedInterviewController>(
      init: PassedInterviewController(),
      builder: (controller) {
        return GetBuilder<JobApplicantsController>(
          init: JobApplicantsController(),
          builder: (jobApplicantsController) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 12,
                  bottom: defaultpadding,
                  left: defaultpadding,
                  right: defaultpadding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Job Offer',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    CustomCard(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: () async {
                            if (controller.passedInterview.isNotEmpty) {
                              final passed = controller.passedInterview[0];

                              final applicantIndex = jobApplicantsController
                                  .totalApplicants
                                  .indexWhere(
                                (applicant) =>
                                    applicant['application_id'] ==
                                    passed['application_id'],
                              );

                              final applicant = jobApplicantsController
                                  .totalApplicants[applicantIndex];
                              final jobId = applicant['job_id'].toString();
                              final appId =
                                  applicant['application_id'].toString();

                              final deletePassedController =
                                  Get.find<DeletePassedController>();
                              await deletePassedController.deletePassedResult(
                                  jobId, appId);

                              final passedInterviewController =
                                  Get.find<PassedInterviewController>();
                              await passedInterviewController
                                  .fetchPassedInterviews(jobId);
                            }

                            Get.to(
                              () => const ApplicantChange(),
                              transition: Transition.upToDown,
                            );
                          },
                          child: const Text('Change Candidate'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () {
                        final passedInterviewController =
                            Get.find<PassedInterviewController>()
                                .passedInterview;

                        if (passedInterviewController.isEmpty) {
                          return Container();
                        }

                        final passed = controller.passedInterview[0];

                        if (passed['is_passed'] == '0') {
                          return Container();
                        }

                        final applicantIndex =
                            jobApplicantsController.totalApplicants.indexWhere(
                          (applicant) =>
                              applicant['application_id'] ==
                              passed['application_id'],
                        );
                        final applicant = jobApplicantsController
                            .totalApplicants[applicantIndex];
                        final firstName =
                            applicant['information']['first_name'];
                        final lastName = applicant['information']['last_name'];
                        final profileUrl =
                            applicant['information']['profile_url'];
                        final email = applicant['information']['email'];

                        return CustomCard(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.network(
                                          profileUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '$firstName $lastName',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        email,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Obx(
                      () {
                        final passedInterview = controller.passedInterview;
                        if (passedInterview.isEmpty) {
                          return Container();
                        }
                        final passed = controller.passedInterview[0];

                        final offer = Get.find<OfferController>().offer;
                        if (passed['is_passed'] == '0') {
                          return Container();
                        } else if (offer.isNotEmpty) {
                          proposedSalary = offer['salary'].toString();
                          proposedSalaryController.text =
                              offer['salary'].toString();
                          selectedBenefits = offer['benefits'].cast<String>();
                          selectedPaymentFrequency =
                              offer['pay_frequency'].toString();
                          selectedDeadline =
                              '${offer['deadline']} ${offer['deadline'] == 1 ? 'day' : 'days'}';
                          status = offer['status'].toString();
                        }

                        return CustomCard(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      if (offer.isEmpty)
                                        const StatusHighlight(
                                          label: 'Status:',
                                          highlightColor: yellowcolor,
                                          text: 'No Offer',
                                        )
                                      else if (status == 'pending')
                                        const StatusHighlight(
                                          label: 'Status:',
                                          highlightColor: yellowcolor,
                                          text: 'Pending',
                                        )
                                      else if (status == 'accepted')
                                        const StatusHighlight(
                                          label: 'Status:',
                                          highlightColor: greencolor,
                                          text: 'Accepted',
                                        )
                                      else if (status == 'updated')
                                        const StatusHighlight(
                                          label: 'Status:',
                                          highlightColor: primarycolor,
                                          text: 'Updated',
                                        )
                                      else if (status == 'declined')
                                        const StatusHighlight(
                                          label: 'Status:',
                                          highlightColor: redcolor,
                                          text: 'declined',
                                        ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.history),
                                    onPressed: () async {
                                      final offerController =
                                          Get.find<OfferController>();

                                      final offerId = offerController
                                          .offer['offer_id']
                                          .toString();

                                      final timelineEventController =
                                          Get.find<TimelineEventController>();
                                      await timelineEventController
                                          .fetchTimelineEvents(offerId);

                                      final timelineEvents =
                                          timelineEventController
                                              .timelineEvents;

                                      Get.to(
                                          () => OfferHistoryScreen(
                                                timelineEvents: timelineEvents,
                                              ),
                                          transition: Transition.rightToLeft);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              SingleItemDropdown(
                                items: availableDeadline,
                                selectedItem: selectedDeadline,
                                onChanged: (value) {
                                  setState(() {
                                    selectedDeadline = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Payment Frequency",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: proposedSalaryController,
                                decoration: InputDecoration(
                                  labelText: "Proposed Salary",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  hintText: 'Proposed Salary (PHP)',
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  border: const OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  proposedSalary = value;
                                },
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 12),
                              SingleItemDropdown(
                                items: availablePaymentFrequency,
                                selectedItem: selectedPaymentFrequency,
                                onChanged: (value) {
                                  selectedPaymentFrequency = value;
                                },
                                decoration: InputDecoration(
                                  labelText: "Payment Frequency",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              DropDownMultiSelect(
                                options: availableBenefits,
                                hintStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                selectedValues: selectedBenefits,
                                onChanged: (selectedItems) {
                                  selectedBenefits =
                                      selectedItems.cast<String>();
                                },
                                decoration: InputDecoration(
                                  labelText: "Select Benefits",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 12),
                              if (offer.isEmpty || status == 'declined')
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.all(12),
                                        ),
                                        onPressed: () async {
                                          final passed =
                                              controller.passedInterview[0];

                                          final applicantIndex =
                                              jobApplicantsController
                                                  .totalApplicants
                                                  .indexWhere(
                                            (applicant) =>
                                                applicant['application_id'] ==
                                                passed['application_id'],
                                          );

                                          final applicant =
                                              jobApplicantsController
                                                      .totalApplicants[
                                                  applicantIndex];
                                          final jobId =
                                              applicant['job_id'].toString();
                                          final appId =
                                              applicant['application_id']
                                                  .toString();

                                          Map<String, dynamic> offerDetails = {
                                            'salary': proposedSalary,
                                            'payFrequency':
                                                selectedPaymentFrequency,
                                            'benefits': selectedBenefits,
                                            'deadline': deadline,
                                          };

                                          final offerController =
                                              Get.find<OfferController>();
                                          final offer =
                                              Get.find<OfferController>().offer;
                                          final createOfferController =
                                              Get.find<CreateOfferController>();
                                          final updateOfferController =
                                              Get.find<UpdateOfferController>();
                                          final createTimelineController =
                                              Get.find<
                                                  CreateTimelineEventController>();

                                          if (offer.isEmpty) {
                                            await createOfferController
                                                .postOffer(
                                                    jobId, appId, offerDetails);
                                            await offerController.fetchOffer(
                                                jobId, appId);

                                            final offerInfo =
                                                offerController.offer;

                                            final offerId =
                                                offerInfo['offer_id']
                                                    .toString();

                                            final userInfo =
                                                Get.find<UserInfoController>()
                                                    .userInfo;
                                            final imageUrl =
                                                userInfo['imageUrl'].toString();
                                            final first = userInfo['firstName']
                                                .toString();
                                            final last =
                                                userInfo['lastName'].toString();

                                            Map<String, dynamic> timelineEvent =
                                                {
                                              'offerId': offerId,
                                              'eventType': 'simple',
                                              'user': '$first $last',
                                              'profile_url': imageUrl,
                                              'action':
                                                  'sent an offer to candidate',
                                            };
                                            await createTimelineController
                                                .postTimelineEvent(
                                                    jobId, timelineEvent);
                                          } else if (status == 'declined') {
                                            await updateOfferController
                                                .updateOffer(
                                                    jobId, appId, offerDetails);
                                            await offerController.fetchOffer(
                                                jobId, appId);

                                            final offerInfo =
                                                offerController.offer;

                                            final offerId =
                                                offerInfo['offer_id']
                                                    .toString();

                                            final userInfo =
                                                Get.find<UserInfoController>()
                                                    .userInfo;
                                            final imageUrl =
                                                userInfo['imageUrl'].toString();
                                            final first = userInfo['firstName']
                                                .toString();
                                            final last =
                                                userInfo['lastName'].toString();

                                            Map<String, dynamic>
                                                updatedTimelineEvent = {
                                              'offerId': offerId,
                                              'eventType': 'simple',
                                              'user': '$first $last',
                                              'profile_url': imageUrl,
                                              'action':
                                                  'updated the offer details',
                                            };
                                            await createTimelineController
                                                .postTimelineEvent(jobId,
                                                    updatedTimelineEvent);
                                          }
                                        },
                                        child: const Text('Submit'),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                            ),
                            onPressed: () async {
                              final applicantsController =
                                  Get.find<JobApplicantsController>();
                              final jobId = applicantsController
                                  .totalApplicants[0]['job_id']
                                  .toString();
                              final updateStepController =
                                  Get.find<UpdateStepController>();
                              await updateStepController.updateApplicationStage(
                                  jobId, 'interview');
                              final resetStepController =
                                  Get.find<ResetStepController>();
                              await resetStepController
                                  .resetCurrentStage(jobId);
                              final passedInterviewController =
                                  Get.find<PassedInterviewController>();
                              await passedInterviewController
                                  .fetchPassedInterviews(jobId);
                              final scheduledApplicantsController =
                                  Get.find<ScheduledApplicantsController>();
                              await scheduledApplicantsController
                                  .fetchInterviewSchedules(jobId);
                              final awaitingApplicantsController =
                                  Get.find<AwaitingApplicantsController>();
                              await awaitingApplicantsController
                                  .fetchScreeningResults(jobId);
                              widget.tabController.animateTo(2);
                            },
                            child: const Text('BACK'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                            ),
                            onPressed: () async {
                              final applicantsController =
                                  Get.find<JobApplicantsController>();
                              final jobId = applicantsController
                                  .totalApplicants[0]['job_id']
                                  .toString();
                              final hiredApplicantController =
                                  Get.find<HiredApplicantController>();
                              await hiredApplicantController
                                  .fetchHiredApplicant(jobId);
                              final updateStepController =
                                  Get.find<UpdateStepController>();
                              await updateStepController.updateApplicationStage(
                                  jobId, 'hired');
                              widget.tabController.animateTo(4);
                            },
                            child: const Text('CONTINUE'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class StepFivePage extends StatelessWidget {
  final TabController tabController;
  const StepFivePage({Key? key, required this.tabController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultpadding),
        child: Column(
          children: [
            Text('Hiring Successful',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Obx(
              () {
                final hiredApplicant =
                    Get.find<HiredApplicantController>().hiredApplicant;
                if (hiredApplicant.isEmpty) {
                  return Container();
                }
                final hired = hiredApplicant[0];
                final firstName = hired['first_name'].toString();
                final lastName = hired['last_name'].toString();
                String profileUrl = hired['profile_url'];
                final fullImageUrl =
                    '${ApiConstants.baseUrl}/assets/$profileUrl';
                final email = hired['email'].toString();

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: CustomCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                    fullImageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$firstName $lastName',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  email,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Congratulations! You found the perfect candidate for your job.',
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 4),
            const Divider(
              color: greycolor,
              thickness: 1,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () async {
                      final applicantsController =
                          Get.find<JobApplicantsController>();
                      final jobId = applicantsController.totalApplicants[0]
                              ['job_id']
                          .toString();
                      final updateStepController =
                          Get.find<UpdateStepController>();
                      await updateStepController.updateApplicationStage(
                          jobId, 'offer');
                      final resetStepController =
                          Get.find<ResetStepController>();
                      await resetStepController.resetCurrentStage(jobId);
                      final passedInterviewController =
                          Get.find<PassedInterviewController>();
                      if (passedInterviewController
                          .passedInterview.isNotEmpty) {
                        final appId = passedInterviewController
                            .passedInterview[0]['application_id']
                            .toString();
                        final offerController = Get.find<OfferController>();
                        await offerController.fetchOffer(jobId, appId);
                        final hiredApplicantController =
                            Get.find<HiredApplicantController>();
                        await hiredApplicantController
                            .fetchHiredApplicant(jobId);
                      }
                      tabController.animateTo(3);
                    },
                    child: const Text('CANCEL'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () async {},
                    child: const Text('VIEW BOOKING'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
