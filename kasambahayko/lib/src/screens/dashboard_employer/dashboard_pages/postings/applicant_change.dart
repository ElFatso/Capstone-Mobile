import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/card/custom_card.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_passed_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_scheduled_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/application_passed_select_controller.dart';
import 'package:kasambahayko/src/controllers/application_process/offer_controller.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';

class ApplicantChange extends StatefulWidget {
  const ApplicantChange({
    Key? key,
  }) : super(key: key);

  @override
  ApplicantChangeState createState() => ApplicantChangeState();
}

class ApplicantChangeState extends State<ApplicantChange> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: EmployerTheme.theme,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(defaultpadding),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Best Applicants',
                        style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 4),
                    const Divider(
                      color: greycolor,
                      thickness: 1,
                    ),
                    const SizedBox(height: 4),
                    GetBuilder<ScheduledApplicantsController>(
                      init: ScheduledApplicantsController(),
                      builder: (scheduledController) {
                        return GetBuilder<JobApplicantsController>(
                          init: JobApplicantsController(),
                          builder: (jobApplicantsController) {
                            return Column(
                              children: [
                                Obx(
                                  () => ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: scheduledController
                                        .completedInterviews.length,
                                    itemBuilder: (context, index) {
                                      final scheduled = scheduledController
                                          .completedInterviews[index];

                                      final applicantIndex =
                                          jobApplicantsController
                                              .totalApplicants
                                              .indexWhere(
                                        (applicant) =>
                                            applicant['application_id'] ==
                                            scheduled['application_id'],
                                      );

                                      if (applicantIndex != -1) {
                                        final applicant =
                                            jobApplicantsController
                                                    .totalApplicants[
                                                applicantIndex];
                                        final jobId =
                                            applicant['job_id'].toString();
                                        final appId =
                                            applicant['application_id']
                                                .toString();
                                        final firstName =
                                            applicant['information']
                                                ['first_name'];
                                        final lastName =
                                            applicant['information']
                                                ['last_name'];
                                        final profileUrl =
                                            applicant['information']
                                                ['profile_url'];
                                        final email =
                                            applicant['information']['email'];

                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          child: CustomCard(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 30,
                                                      backgroundColor:
                                                          Colors.white,
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '$firstName $lastName',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 6),
                                                        Text(
                                                          email,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                  ),
                                                  onPressed: () async {
                                                    final selectPassedController =
                                                        Get.find<
                                                            SelectPassedController>();
                                                    await selectPassedController
                                                        .passInterview(
                                                      jobId,
                                                      appId,
                                                    );

                                                    final passedInterviewController =
                                                        Get.find<
                                                            PassedInterviewController>();
                                                    await passedInterviewController
                                                        .fetchPassedInterviews(
                                                            jobId);

                                                    final offerController =
                                                        Get.find<
                                                            OfferController>();
                                                    await offerController
                                                        .fetchOffer(
                                                            jobId, appId);

                                                    Get.back();
                                                  },
                                                  child: const Text(
                                                      'Select Candidate'),
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
