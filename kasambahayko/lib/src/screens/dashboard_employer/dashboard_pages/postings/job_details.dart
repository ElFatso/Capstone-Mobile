import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/highlight.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/image_strings.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/delete_post_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/job_post_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/postings/edit_post.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';

class JobDetailsScreen extends StatelessWidget {
  final uuid = Get.find<UserInfoController>().userInfo['uuid']?.toString();
  final String jobId;
  final String jobTitle;
  final String jobType;
  final String serviceType;
  final String serviceId;
  final String jobStatus;
  final String jobDescription;
  final String formattedJobStartDate;
  final String formattedJobEndDate;
  final String jobStartTime;
  final String jobEndTime;
  final String selectedLivingArrangement;

  JobDetailsScreen({
    super.key,
    required this.jobId,
    required this.jobTitle,
    required this.jobType,
    required this.serviceType,
    required this.jobStatus,
    required this.jobDescription,
    required this.formattedJobStartDate,
    required this.formattedJobEndDate,
    required this.selectedLivingArrangement,
    required this.jobStartTime,
    required this.jobEndTime,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: EmployerTheme.theme,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(defaultpadding),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      jobTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      selectedLivingArrangement,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Highlight(
                                label: 'Job Status:',
                                text: jobStatus,
                                highlightColor: greencolor,
                              ),
                              const SizedBox(height: 12),
                              Highlight(
                                label: 'Type:',
                                text: jobType,
                                highlightColor: bluecolor,
                              ),
                              const SizedBox(height: 12),
                              Highlight(
                                label: 'Service:',
                                text: serviceType,
                                highlightColor: orangecolor,
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image(
                              image: AssetImage(jobDetails),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      jobDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Start Date: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: DateFormat('yyyy-MM-dd').format(
                                    DateTime.parse(formattedJobStartDate)),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Start Time: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: jobStartTime,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'End Date: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: DateFormat('yyyy-MM-dd').format(
                                    DateTime.parse(formattedJobEndDate)),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'End Time: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: jobEndTime,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 24),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: redcolor,
                                side: const BorderSide(color: redcolor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.all(16)),
                            onPressed: () async {
                              final deletePostController =
                                  Get.find<DeletePostController>();
                              await deletePostController.deleteJobPost(jobId);

                              final jobPostsController =
                                  Get.find<JobPostsController>();
                              await jobPostsController
                                  .reloadJobPosts(uuid ?? '');
                              jobPostsController.obs.refresh();
                              Get.to(() => const EmployerDashboardScreen(
                                    initialPage:
                                        EmployerDashboardSections.posts,
                                  ));
                            },
                            child: const Text('Delete'),
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
                              Get.to(
                                  () => EditPostScreen(
                                        jobId: jobId,
                                        jobTitle: jobTitle,
                                        jobType: jobType,
                                        jobStatus: jobStatus,
                                        jobDescription: jobDescription,
                                        formattedJobStartDate:
                                            formattedJobStartDate,
                                        formattedJobEndDate:
                                            formattedJobEndDate,
                                        jobStartTime: jobStartTime,
                                        jobEndTime: jobEndTime,
                                        selectedLivingArrangement:
                                            selectedLivingArrangement,
                                        serviceId: serviceId,
                                      ),
                                  transition: Transition.downToUp);
                            },
                            child: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
