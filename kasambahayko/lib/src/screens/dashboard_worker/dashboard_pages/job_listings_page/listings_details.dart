import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/highlight.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/creation_applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/job_listings_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_worker.dart';

class ListingDetailsScreen extends StatelessWidget {
  final String profileUrl;
  final String lastName;
  final String firstName;
  final String city;
  final String distance;
  final String jobId;
  final String jobTitle;
  final String jobDescription;
  final String jobType;
  final String jobStatus;
  final String serviceType;
  final String formattedJobStartDate;
  final String formattedJobEndDate;
  final String jobStartTime;
  final String jobEndTime;
  final String livingArrangement;

  const ListingDetailsScreen({
    super.key,
    required this.profileUrl,
    required this.lastName,
    required this.firstName,
    required this.city,
    required this.distance,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobType,
    required this.serviceType,
    required this.jobStartTime,
    required this.jobEndTime,
    required this.livingArrangement,
    required this.jobStatus,
    required this.formattedJobStartDate,
    required this.formattedJobEndDate,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: WorkerTheme.theme,
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
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(
                                profileUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
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
                            const SizedBox(height: 8),
                            Text(
                              '$city - $distance kilometers',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              livingArrangement,
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
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Highlight(
                          label: 'Service:',
                          text: serviceType,
                          highlightColor: orangecolor,
                        ),
                        const SizedBox(height: 12),
                        Highlight(
                          label: 'Type:',
                          text: jobType,
                          highlightColor: bluecolor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
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
                                text: formattedJobStartDate,
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
                                text: formattedJobEndDate,
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
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      jobDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(12),
                      ),
                      onPressed: () async {
                        final uuid = Get.find<UserInfoController>()
                            .userInfo['uuid']
                            .toString();
                        final applyJobController =
                            Get.find<ApplyJobController>();
                        final appliedJobsController =
                            Get.find<AppliedJobsController>();
                        final jobListingsController =
                            Get.find<JobListingsController>();

                        await applyJobController.applyForJob(uuid, jobId);

                        await appliedJobsController.fetchAppliedJobs(uuid);
                        appliedJobsController.filteredAppliedJobs.refresh();
                        await jobListingsController.fetchJobListings(uuid);
                        jobListingsController.filteredListings.refresh();

                        Get.to(() => const WorkerDashboardScreen(
                              initialPage: WorkerDashboardSections.listings,
                            ));
                      },
                      child: const Text('Apply Now'),
                    ),
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
