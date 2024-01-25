import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/highlight.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_scheduled_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/timeline_create_controller.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/deletion_applied_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/job_listings_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/progress_timeline_accept_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/progress_timeline_controller.dart';
import 'package:kasambahayko/src/controllers/job_listings/progress_timeline_decline_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_worker.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class AppliedListingDetailsScreen extends StatelessWidget {
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
  final List<Map<String, dynamic>> progressTimeline;

  const AppliedListingDetailsScreen({
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
    required this.progressTimeline,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: WorkerTheme.theme,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
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
                    if (!progressTimeline.any((event) =>
                        event['event_description'] == 'Screening Passed'))
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          const Divider(
                            color: greycolor,
                            thickness: 1,
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            onPressed: () async {
                              final uuid = Get.find<UserInfoController>()
                                  .userInfo['uuid']
                                  .toString();
                              final deleteApplicationController =
                                  Get.find<DeleteApplicationController>();
                              final appliedJobsController =
                                  Get.find<AppliedJobsController>();
                              final jobListingsController =
                                  Get.find<JobListingsController>();

                              await deleteApplicationController
                                  .deleteApplication(uuid, jobId);

                              await appliedJobsController
                                  .fetchAppliedJobs(uuid);
                              appliedJobsController.filteredAppliedJobs
                                  .refresh();
                              await jobListingsController
                                  .fetchJobListings(uuid);
                              jobListingsController.filteredListings.refresh();

                              Get.to(() => const WorkerDashboardScreen(
                                    initialPage:
                                        WorkerDashboardSections.listings,
                                  ));
                            },
                            child: const Text('Cancel Application'),
                          ),
                        ],
                      ),
                    if (progressTimeline.isNotEmpty)
                      Obx(
                        () {
                          return Column(
                            children: [
                              const SizedBox(height: 16),
                              const Divider(
                                color: greycolor,
                                thickness: 1,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Application Progress',
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Divider(
                                color: greycolor,
                                thickness: 1,
                              ),
                              if (progressTimeline.any((event) =>
                                  event['event_description'] ==
                                  'Application Submitted'))
                                TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  isFirst: true,
                                  lineXY: 0.2,
                                  indicatorStyle: IndicatorStyle(
                                    width: 40,
                                    color: greencolor,
                                    iconStyle: IconStyle(
                                        color: whitecolor,
                                        iconData:
                                            Icons.check_circle_outline_rounded),
                                  ),
                                  afterLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 120,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Application Submitted',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Your application has been submitted.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (progressTimeline.any((event) =>
                                  event['event_description'] ==
                                  'Screening Passed'))
                                TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  lineXY: 0.2,
                                  indicatorStyle: IndicatorStyle(
                                    width: 40,
                                    color: greencolor,
                                    iconStyle: IconStyle(
                                        color: whitecolor,
                                        iconData:
                                            Icons.check_circle_outline_rounded),
                                  ),
                                  beforeLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  afterLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 120,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Screening Passed',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'You have passed the screening process.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (progressTimeline.any((event) =>
                                  event['event_description'] ==
                                  'Interview Scheduled'))
                                TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  lineXY: 0.2,
                                  indicatorStyle: IndicatorStyle(
                                    width: 40,
                                    color: bluecolor,
                                    iconStyle: IconStyle(
                                        color: whitecolor,
                                        iconData: Icons.info_outline_rounded),
                                  ),
                                  beforeLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  afterLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 120,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Interview Scheduled',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Your interview has been scheduled.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Obx(
                                              () {
                                                final scheduledInterviewsController =
                                                    Get.find<
                                                        ScheduledApplicantsController>();

                                                if (scheduledInterviewsController
                                                    .scheduledInterviews
                                                    .isNotEmpty) {
                                                  final scheduled = Get.find<
                                                          ScheduledApplicantsController>()
                                                      .scheduledInterviews[0];

                                                  final scheduledTime =
                                                      scheduled[
                                                          'scheduled_time'];
                                                  final scheduledDate =
                                                      scheduled[
                                                          'scheduled_date'];
                                                  final link = scheduled[
                                                      'interview_link'];
                                                  Uri url = Uri.parse(link);

                                                  List<String> timeComponents =
                                                      scheduledTime.split(':');
                                                  TimeOfDay timeOfDay =
                                                      TimeOfDay(
                                                    hour: int.parse(
                                                        timeComponents[0]),
                                                    minute: int.parse(
                                                        timeComponents[1]),
                                                  );

                                                  final formattedTime =
                                                      DateFormat('h:mm a')
                                                          .format(DateTime(
                                                    0,
                                                    1,
                                                    1,
                                                    timeOfDay.hour,
                                                    timeOfDay.minute,
                                                  ));
                                                  final date = DateTime.parse(
                                                      scheduledDate);
                                                  final formattedDate =
                                                      DateFormat('MMMM d, y')
                                                          .format(date);

                                                  return !progressTimeline.any(
                                                          (event) => event[
                                                                  'event_description']
                                                              .contains(
                                                                  'Interview Completed'))
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                                height: 4),
                                                            const Divider(
                                                              color: greycolor,
                                                              thickness: 1,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              '$formattedDate at $formattedTime',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text.rich(
                                                              TextSpan(
                                                                text: '$url',
                                                                style:
                                                                    const TextStyle(
                                                                  color:
                                                                      bluecolor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () {
                                                                        launchUrl(
                                                                            url,
                                                                            mode:
                                                                                LaunchMode.externalNonBrowserApplication);
                                                                      },
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : const Column();
                                                }
                                                return const Column();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (progressTimeline.any((event) =>
                                  event['event_description'] ==
                                  'Interview Completed'))
                                TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  lineXY: 0.2,
                                  indicatorStyle: IndicatorStyle(
                                    width: 40,
                                    color: greencolor,
                                    iconStyle: IconStyle(
                                        color: whitecolor,
                                        iconData:
                                            Icons.check_circle_outline_rounded),
                                  ),
                                  beforeLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  afterLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 120,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Interview Completed',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Your interview has been completed.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (progressTimeline.any((event) =>
                                  event['event_description'] == 'Job Offer'))
                                TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  lineXY: 0.2,
                                  indicatorStyle: IndicatorStyle(
                                    width: 40,
                                    color: bluecolor,
                                    iconStyle: IconStyle(
                                        color: whitecolor,
                                        iconData: Icons.info_outline_rounded),
                                  ),
                                  beforeLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  afterLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 120,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Job Offer',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'You have been offered a job. Congratulations!',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Obx(
                                              () {
                                                final offerController =
                                                    Get.find<OfferController>();
                                                if (offerController
                                                    .offer.isNotEmpty) {
                                                  final offer = Get.find<
                                                          OfferController>()
                                                      .offer;

                                                  String salaryString =
                                                      offer['salary']
                                                          .toString();

                                                  double proposedSalary =
                                                      double.tryParse(
                                                              salaryString) ??
                                                          0.0;

                                                  NumberFormat currencyFormat =
                                                      NumberFormat.currency(
                                                          symbol: '₱ ',
                                                          decimalDigits: 2);
                                                  final formattedSalary =
                                                      currencyFormat.format(
                                                          proposedSalary);

                                                  List<dynamic> benefitsData =
                                                      offer['benefits'];
                                                  List<String> benefits =
                                                      benefitsData
                                                          .map((dynamic
                                                                  element) =>
                                                              element
                                                                  .toString())
                                                          .map((String
                                                                  benefit) =>
                                                              '• $benefit')
                                                          .toList();

                                                  final selectedBenefits =
                                                      benefits.join('\n');

                                                  final selectedPaymentFrequency =
                                                      offer['pay_frequency']
                                                          .toString();
                                                  final selectedDeadline =
                                                      '${offer['deadline']} ${offer['deadline'] == 1 ? 'day' : 'days'}';

                                                  String? updatedAtString =
                                                      offer['updated_at'];

                                                  DateTime? updatedAt;

                                                  if (updatedAtString != null) {
                                                    updatedAt =
                                                        DateTime.tryParse(
                                                            updatedAtString);
                                                  }

                                                  String updated =
                                                      'No recent changes';

                                                  if (updatedAt != null) {
                                                    String formatDate =
                                                        DateFormat('MMMM d, y')
                                                            .format(updatedAt);
                                                    String formatTime =
                                                        DateFormat('h:mm a')
                                                            .format(updatedAt);

                                                    updated =
                                                        '$formatDate at $formatTime';
                                                  }

                                                  final appId =
                                                      offer['application_id']
                                                          .toString();

                                                  final status = offer['status']
                                                      .toString();

                                                  return !progressTimeline.any(
                                                          (event) => event[
                                                                  'event_description']
                                                              .contains(
                                                                  'Job Offer Accepted'))
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const SizedBox(
                                                                height: 4),
                                                            const Divider(
                                                              color: greycolor,
                                                              thickness: 1,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              'Last Updated',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              updated,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                            const Divider(
                                                              color: greycolor,
                                                              thickness: 1,
                                                            ),
                                                            Text(
                                                              'Deadline',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              '$selectedDeadline from now',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                            const Divider(
                                                              color: greycolor,
                                                              thickness: 1,
                                                            ),
                                                            Text(
                                                              'Proposed Salary',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              formattedSalary,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                            const Divider(
                                                              color: greycolor,
                                                              thickness: 1,
                                                            ),
                                                            Text(
                                                              'Payment Frequency',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              selectedPaymentFrequency,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                            const Divider(
                                                              color: greycolor,
                                                              thickness: 1,
                                                            ),
                                                            Text(
                                                              'Benefits',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
                                                            const SizedBox(
                                                                height: 4),
                                                            Text(
                                                              selectedBenefits,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                            ),
                                                            const Divider(
                                                              color: greycolor,
                                                              thickness: 1,
                                                            ),
                                                            if (status ==
                                                                    'pending' ||
                                                                status ==
                                                                    'updated')
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  const SizedBox(
                                                                      width:
                                                                          16),
                                                                  Expanded(
                                                                    child:
                                                                        OutlinedButton(
                                                                      style: OutlinedButton
                                                                          .styleFrom(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            12),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        final declineJobOfferController =
                                                                            Get.find<DeclineJobOfferController>();
                                                                        await declineJobOfferController
                                                                            .declineJobOffer(appId);
                                                                        await offerController.fetchOffer(
                                                                            jobId,
                                                                            appId);

                                                                        final offerInfo =
                                                                            offerController.offer;

                                                                        final offerId =
                                                                            offerInfo['offer_id'].toString();

                                                                        final userInfo =
                                                                            Get.find<UserInfoController>().userInfo;
                                                                        final imageUrl =
                                                                            userInfo['imageUrl'].toString();
                                                                        final first =
                                                                            userInfo['firstName'].toString();
                                                                        final last =
                                                                            userInfo['lastName'].toString();

                                                                        Map<String,
                                                                                dynamic>
                                                                            timelineEvent =
                                                                            {
                                                                          'offerId':
                                                                              offerId,
                                                                          'eventType':
                                                                              'simple',
                                                                          'user':
                                                                              '$first $last',
                                                                          'profile_url':
                                                                              imageUrl,
                                                                          'action':
                                                                              'declined the offer',
                                                                        };

                                                                        final createTimelineEventController =
                                                                            Get.find<CreateTimelineEventController>();
                                                                        await createTimelineEventController
                                                                            .postTimelineEvent(
                                                                          jobId,
                                                                          timelineEvent,
                                                                        );
                                                                      },
                                                                      child: const Text(
                                                                          'Decline'),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          16),
                                                                  Expanded(
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            12),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        final acceptJobOfferController =
                                                                            Get.find<AcceptJobOfferController>();
                                                                        await acceptJobOfferController.acceptJobOffer(
                                                                            jobId,
                                                                            appId);

                                                                        await offerController.fetchOffer(
                                                                            jobId,
                                                                            appId);

                                                                        final offerInfo =
                                                                            offerController.offer;

                                                                        final offerId =
                                                                            offerInfo['offer_id'].toString();

                                                                        final userInfo =
                                                                            Get.find<UserInfoController>().userInfo;
                                                                        final imageUrl =
                                                                            userInfo['imageUrl'].toString();
                                                                        final first =
                                                                            userInfo['firstName'].toString();
                                                                        final last =
                                                                            userInfo['lastName'].toString();

                                                                        Map<String,
                                                                                dynamic>
                                                                            timelineEvent =
                                                                            {
                                                                          'offerId':
                                                                              offerId,
                                                                          'eventType':
                                                                              'simple',
                                                                          'user':
                                                                              '$first $last',
                                                                          'profile_url':
                                                                              imageUrl,
                                                                          'action':
                                                                              'accepted the offer',
                                                                        };

                                                                        final createTimelineEventController =
                                                                            Get.find<CreateTimelineEventController>();
                                                                        await createTimelineEventController
                                                                            .postTimelineEvent(
                                                                          jobId,
                                                                          timelineEvent,
                                                                        );

                                                                        final progressTimelineController =
                                                                            Get.find<ProgressTimelineController>();
                                                                        await progressTimelineController.fetchProgressTimeline(
                                                                            jobId,
                                                                            appId);
                                                                      },
                                                                      child: const Text(
                                                                          'Accept'),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          16),
                                                                ],
                                                              ),
                                                          ],
                                                        )
                                                      : const Column();
                                                }
                                                return const Column();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (progressTimeline.any((event) =>
                                  event['event_description'] ==
                                  'Job Offer Accepted'))
                                TimelineTile(
                                  alignment: TimelineAlign.manual,
                                  isLast: true,
                                  lineXY: 0.2,
                                  indicatorStyle: IndicatorStyle(
                                    width: 40,
                                    color: greencolor,
                                    iconStyle: IconStyle(
                                        color: whitecolor,
                                        iconData:
                                            Icons.check_circle_outline_rounded),
                                  ),
                                  beforeLineStyle: const LineStyle(
                                    color: graycolor,
                                    thickness: 4,
                                  ),
                                  endChild: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 120,
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Job Offer Accepted',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'You have accepted the job offer. You can now view the booking details.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            const SizedBox(height: 4),
                                            const Divider(
                                              color: greycolor,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                    ),
                                                    onPressed: () async {},
                                                    child: const Text(
                                                        'View Bookings'),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
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
