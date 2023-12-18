import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/common_widgets/card/custom_card.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/highlight.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_scheduled_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/job_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/progress_timeline_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/job_listings_page/applied_listings_detail.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/job_listings_page/filter_listings.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/job_listings_page/listings_details.dart';

String truncateString(String input, int maxLength) {
  if (input.length <= maxLength) {
    return input;
  } else {
    int lastSpace = input.lastIndexOf(' ', maxLength);
    if (lastSpace != -1) {
      return '${input.substring(0, lastSpace)}...';
    } else {
      return '${input.substring(0, maxLength)}...';
    }
  }
}

class ListingsPage extends StatelessWidget {
  final uuid = Get.find<UserInfoController>().userInfo['uuid']?.toString();

  ListingsPage({super.key});

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
                        () => FilterListings(
                          selectedServiceName:
                              JobListingsController().selectedServiceName,
                          selectedLivingArrangement:
                              JobListingsController().selectedLivingArrangement,
                        ),
                        transition: Transition.upToDown,
                      );
                    },
                    child: const Text('Filter Job Posts'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TabBar(
                indicatorColor: secondarycolor,
                labelStyle: Theme.of(context).textTheme.titleSmall,
                labelColor: secondarycolor,
                tabs: const [
                  Tab(text: 'Browse Jobs'),
                  Tab(text: 'Applied Jobs'),
                ],
                unselectedLabelColor: blackcolor,
              ),
              const SizedBox(height: 12),
              const Expanded(
                child: TabBarView(
                  children: [
                    BrowseJobsTab(),
                    AppliedJobsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BrowseJobsTab extends StatelessWidget {
  const BrowseJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobListingsController>(
        init: JobListingsController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.error.isNotEmpty) {
            return Center(child: Text('Error: ${controller.error}'));
          } else {}
          return ListView.builder(
            itemCount: controller.filteredListings.length,
            itemBuilder: (context, index) {
              final post = controller.filteredListings[index];
              final jobId = post['job_id'].toString();
              final formattedJobTitle = truncateString(post['job_title'], 25);
              final jobTitle = post['job_title'];
              final jobDescription = post['job_description'];
              final jobType = post['job_type'];
              final serviceId = post['service_id'].toString();
              final jobStatus = post['job_status'];
              final jobStartDate = post['job_start_date'];
              final jobEndDate = post['job_end_date'];
              final jobStartTime = post['job_start_time'];
              final jobEndTime = post['job_end_time'];
              final livingArrangement = post['living_arrangement'];
              final profileUrl = post['profile_url'];
              final firstName = post['first_name'];
              final lastName = post['last_name'];
              final city = post['city_municipality'];
              final distance = post['distance'].toString();

              final startDate = DateFormat('yyyy-MM-dd').parse(jobStartDate);
              final endDate = DateFormat('yyyy-MM-dd').parse(jobEndDate);

              final updatedStartDate = startDate.add(const Duration(days: 1));
              final updatedEndDate = endDate.add(const Duration(days: 1));

              final formattedJobStartDate =
                  DateFormat('yyyy-MM-dd').format(updatedStartDate);
              final formattedJobEndDate =
                  DateFormat('yyyy-MM-dd').format(updatedEndDate);

              Map<String, String> serviceIdToName = {
                '1': 'Child Care',
                '2': 'Elder Care',
                '3': 'Pet Care',
                '4': 'House Services',
              };

              final serviceType = serviceIdToName[serviceId];

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
                                formattedJobTitle,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '$city - $distance kilometers',
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
                            text: serviceType!,
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
                      Text(
                        jobDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(12),
                        ),
                        onPressed: () {
                          Get.to(
                              () => ListingDetailsScreen(
                                    profileUrl: profileUrl,
                                    lastName: lastName,
                                    firstName: firstName,
                                    city: city,
                                    distance: distance,
                                    jobId: jobId,
                                    jobTitle: jobTitle,
                                    jobDescription: jobDescription,
                                    jobType: jobType,
                                    serviceType: serviceType,
                                    jobStatus: jobStatus,
                                    formattedJobStartDate:
                                        formattedJobStartDate,
                                    formattedJobEndDate: formattedJobEndDate,
                                    jobStartTime: jobStartTime,
                                    jobEndTime: jobEndTime,
                                    livingArrangement: livingArrangement,
                                  ),
                              transition: Transition.rightToLeft);
                        },
                        child: const Text('View Job Details'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

class AppliedJobsTab extends StatelessWidget {
  const AppliedJobsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppliedJobsController>(
        init: AppliedJobsController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.error.isNotEmpty) {
            return Center(child: Text('Error: ${controller.error}'));
          } else {}
          return ListView.builder(
            itemCount: controller.filteredAppliedJobs.length,
            itemBuilder: (context, index) {
              final appJob = controller.filteredAppliedJobs[index];
              final jobId = appJob['post']['job_id'].toString();
              final formattedJobTitle =
                  truncateString(appJob['post']['job_title'], 25);
              final jobTitle = appJob['post']['job_title'];
              final jobDescription = appJob['post']['job_description'];
              final jobType = appJob['post']['job_type'];
              final serviceId = appJob['post']['service_id'].toString();
              final jobStatus = appJob['post']['job_status'];
              final jobStartDate = appJob['post']['job_start_date'];
              final jobEndDate = appJob['post']['job_end_date'];
              final jobStartTime = appJob['post']['job_start_time'];
              final jobEndTime = appJob['post']['job_end_time'];
              final livingArrangement = appJob['post']['living_arrangement'];
              final profileUrl = appJob['post']['profile_url'];
              final firstName = appJob['post']['first_name'];
              final lastName = appJob['post']['last_name'];
              final city = appJob['post']['city_municipality'];
              final distance = appJob['post']['distance'].toString();

              final startDate = DateFormat('yyyy-MM-dd').parse(jobStartDate);
              final endDate = DateFormat('yyyy-MM-dd').parse(jobEndDate);

              final updatedStartDate = startDate.add(const Duration(days: 1));
              final updatedEndDate = endDate.add(const Duration(days: 1));

              final formattedJobStartDate =
                  DateFormat('yyyy-MM-dd').format(updatedStartDate);
              final formattedJobEndDate =
                  DateFormat('yyyy-MM-dd').format(updatedEndDate);

              Map<String, String> serviceIdToName = {
                '1': 'Child Care',
                '2': 'Elder Care',
                '3': 'Pet Care',
                '4': 'House Services',
              };

              final serviceType = serviceIdToName[serviceId];

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
                                formattedJobTitle,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '$city - $distance kilometers',
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
                            text: serviceType!,
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
                      Text(
                        jobDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(12),
                        ),
                        onPressed: () async {
                          final progressTimelineController =
                              Get.find<ProgressTimelineController>();
                          final scheduledApplicantsController =
                              Get.find<ScheduledApplicantsController>();
                          final offerController = Get.find<OfferController>();
                          final appId = appJob['application_id'].toString();
                          final progressTimeline =
                              progressTimelineController.progressTimeline;

                          await progressTimelineController
                              .fetchProgressTimeline(jobId, appId);
                          await scheduledApplicantsController
                              .fetchInterviewSchedules(jobId);
                          await offerController.fetchOffer(jobId, appId);

                          Get.to(
                              () => AppliedListingDetailsScreen(
                                    progressTimeline: progressTimeline,
                                    profileUrl: profileUrl,
                                    lastName: lastName,
                                    firstName: firstName,
                                    city: city,
                                    distance: distance,
                                    jobId: jobId,
                                    jobTitle: jobTitle,
                                    jobDescription: jobDescription,
                                    jobType: jobType,
                                    serviceType: serviceType,
                                    jobStatus: jobStatus,
                                    formattedJobStartDate:
                                        formattedJobStartDate,
                                    formattedJobEndDate: formattedJobEndDate,
                                    jobStartTime: jobStartTime,
                                    jobEndTime: jobEndTime,
                                    livingArrangement: livingArrangement,
                                  ),
                              transition: Transition.rightToLeft);
                        },
                        child: const Text('View Application Details'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
