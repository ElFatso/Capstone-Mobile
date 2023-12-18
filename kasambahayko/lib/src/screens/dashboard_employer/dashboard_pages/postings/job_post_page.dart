import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/common_widgets/card/custom_card.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/highlight.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/application_process/applicant_hiring_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_awaiting_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_passed_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_scheduled_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/step_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/job_post_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/postings/create_post.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/postings/job_details.dart';

class JobPostPage extends StatefulWidget {
  final Function(EmployerDashboardSections) onSectionSelected;
  const JobPostPage({Key? key, required this.onSectionSelected})
      : super(key: key);

  @override
  JobPostsPageState createState() => JobPostsPageState();
}

class JobPostsPageState extends State<JobPostPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.only(
            bottom: defaultpadding,
            left: defaultpadding,
            right: defaultpadding),
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                indicatorColor: primarycolor,
                labelStyle: Theme.of(context).textTheme.titleSmall,
                labelColor: primarycolor,
                unselectedLabelColor: blackcolor,
                tabs: const [
                  Tab(text: 'Active Jobs'),
                  Tab(text: 'Job History'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    BrowseJobsTab(onSectionSelected: widget.onSectionSelected),
                    const Center(
                        child: Text(
                      'Welcome to Tab 2!',
                      style: TextStyle(fontSize: 24),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BrowseJobsTab extends StatelessWidget {
  final Function(EmployerDashboardSections) onSectionSelected;
  const BrowseJobsTab({super.key, required this.onSectionSelected});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobPostsController>(
        init: JobPostsController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.error.isNotEmpty) {
            return Center(child: Text('Error: ${controller.error}'));
          } else {}
          return ListView.builder(
            itemCount: controller.jobPosts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12, top: 12),
                  child: CustomCard(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            padding: const EdgeInsets.all(16)),
                        onPressed: () {
                          Get.to(() => const CreatePostScreen(),
                              transition: Transition.upToDown);
                        },
                        child: const Text('Create a New Post'),
                      ),
                    ),
                  ),
                );
              } else {
                final post = controller.jobPosts[index - 1];
                final jobId = post['job_id'].toString();
                final jobTitle = post['job_title'];
                final jobDescription = post['job_description'];
                final jobType = post['job_type'];
                final serviceId = post['service_id'].toString();
                final serviceType = post['service_name'];
                final jobStatus = post['job_status'];
                final jobStartDate = post['job_start_date'];
                final jobEndDate = post['job_end_date'];
                final jobStartTime = post['job_start_time'];
                final jobEndTime = post['job_end_time'];
                final livingArrangement = post['living_arrangement'];

                final startDate = DateFormat('yyyy-MM-dd').parse(jobStartDate);
                final endDate = DateFormat('yyyy-MM-dd').parse(jobEndDate);

                final updatedStartDate = startDate.add(const Duration(days: 1));
                final updatedEndDate = endDate.add(const Duration(days: 1));

                final formattedJobStartDate =
                    DateFormat('yyyy-MM-dd').format(updatedStartDate);
                final formattedJobEndDate =
                    DateFormat('yyyy-MM-dd').format(updatedEndDate);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: CustomCard(
                    child: Column(
                      children: [
                        Text(
                          jobTitle,
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Highlight(
                              label: 'Type:',
                              text: jobType,
                              highlightColor: bluecolor,
                            ),
                            Highlight(
                              label: 'Service:',
                              text: serviceType,
                              highlightColor: orangecolor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          jobDescription,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const SizedBox(width: 16),
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(12)),
                                onPressed: () {
                                  Get.to(
                                      () => JobDetailsScreen(
                                            jobId: jobId,
                                            jobTitle: jobTitle,
                                            jobType: jobType,
                                            serviceType: serviceType,
                                            jobStatus: jobStatus,
                                            jobDescription: jobDescription,
                                            formattedJobStartDate:
                                                formattedJobStartDate,
                                            formattedJobEndDate:
                                                formattedJobEndDate,
                                            jobStartTime: jobStartTime,
                                            jobEndTime: jobEndTime,
                                            selectedLivingArrangement:
                                                livingArrangement,
                                            serviceId: serviceId,
                                          ),
                                      transition: Transition.rightToLeft);
                                },
                                child: const Text('View Details'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(12),
                                ),
                                onPressed: () async {
                                  final stepController =
                                      Get.find<StepController>();
                                  stepController.fetchApplicationStage(jobId);

                                  final applicantsController =
                                      Get.find<JobApplicantsController>();
                                  await applicantsController
                                      .fetchJobApplicants(jobId);

                                  final awaitingApplicantsController =
                                      Get.find<AwaitingApplicantsController>();
                                  await awaitingApplicantsController
                                      .fetchScreeningResults(jobId);

                                  final scheduledApplicantsController =
                                      Get.find<ScheduledApplicantsController>();
                                  await scheduledApplicantsController
                                      .fetchInterviewSchedules(jobId);

                                  final passedInterviewController =
                                      Get.find<PassedInterviewController>();
                                  await passedInterviewController
                                      .fetchPassedInterviews(jobId);

                                  if (passedInterviewController
                                      .passedInterview.isNotEmpty) {
                                    final appId = passedInterviewController
                                        .passedInterview[0]['application_id']
                                        .toString();

                                    final offerController =
                                        Get.find<OfferController>();
                                    await offerController.fetchOffer(
                                        jobId, appId);
                                  }

                                  final hiredapplicantController =
                                      Get.find<HiredApplicantController>();
                                  await hiredapplicantController
                                      .fetchHiredApplicant(jobId);

                                  onSectionSelected(
                                      EmployerDashboardSections.applications);
                                },
                                child: const Text('View Applicants'),
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        });
  }
}
