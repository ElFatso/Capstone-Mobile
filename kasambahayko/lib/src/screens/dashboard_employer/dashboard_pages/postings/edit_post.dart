import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/living_arrangments_input_field.dart';
import 'package:kasambahayko/src/common_widgets/picker/date_picker/date_picker.dart';
import 'package:kasambahayko/src/common_widgets/picker/time_picker/time_picker.dart';
import 'package:kasambahayko/src/common_widgets/radio_buttons/radio_list.dart';
import 'package:kasambahayko/src/constants/image_strings.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/edit_post_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/job_post_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';

class EditPostScreen extends StatefulWidget {
  final uuid = Get.find<UserInfoController>().userInfo['uuid']?.toString();
  final String jobId;
  final String jobTitle;
  final String jobType;
  final String serviceId;
  final String jobStatus;
  final String jobDescription;
  final String formattedJobStartDate;
  final String formattedJobEndDate;
  final String jobStartTime;
  final String jobEndTime;
  final String livingArrangement;
  EditPostScreen({
    Key? key,
    required this.jobId,
    required this.jobTitle,
    required this.jobType,
    required this.jobStatus,
    required this.jobDescription,
    required this.formattedJobStartDate,
    required this.formattedJobEndDate,
    required this.livingArrangement,
    required this.jobStartTime,
    required this.jobEndTime,
    required this.serviceId,
  }) : super(key: key);

  @override
  EditPostScreenState createState() => EditPostScreenState();
}

class EditPostScreenState extends State<EditPostScreen> {
  int currentStep = 0;
  final uuid = Get.find<UserInfoController>().userInfo['uuid']?.toString();
  String serviceType = '';
  String jobType = '';
  String jobTitle = '';
  String jobDescription = '';
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController jobTitleController = TextEditingController();
  DateTime jobStartDate = DateTime.now();
  DateTime jobEndDate = DateTime.now();
  DateTime jobStartTime = DateTime.now();
  DateTime jobEndTime = DateTime.now();
  String? livingArrangement;

  @override
  void initState() {
    super.initState();
    jobTitleController.text = widget.jobTitle;
    jobDescriptionController.text = widget.jobDescription;
    jobTitle = widget.jobTitle;
    jobDescription = widget.jobDescription;
    jobType = widget.jobType;
    serviceType = widget.serviceId;
    livingArrangement = widget.livingArrangement;
    jobStartDate = DateFormat('yyyy-MM-dd').parse(widget.formattedJobStartDate);
    jobEndDate = DateFormat('yyyy-MM-dd').parse(widget.formattedJobEndDate);
    jobStartTime = DateFormat('HH:mm').parse(widget.jobStartTime);
    jobEndTime = DateFormat('HH:mm').parse(widget.jobEndTime);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: EmployerTheme.theme,
        child: Scaffold(
          body: Stepper(
            type: StepperType.horizontal,
            steps: getsteps(),
            currentStep: currentStep,
            onStepTapped: (step) => setState(() => currentStep = step),
            controlsBuilder:
                (BuildContext context, ControlsDetails controlsDetails) {
              final lastStep = currentStep == getsteps().length - 1;
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controlsDetails.onStepContinue,
                        child: Text(lastStep ? 'CONFIRM' : 'NEXT'),
                      ),
                    ),
                    if (currentStep != 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controlsDetails.onStepCancel,
                          child: const Text('BACK'),
                        ),
                      ),
                  ],
                ),
              );
            },
            onStepContinue: () async {
              final isLastStep = currentStep == getsteps().length - 1;

              if (isLastStep) {
                final editPostController = Get.find<EditPostController>();
                final jobPostsController = Get.find<JobPostsController>();

                editPostController.updateJobPost(
                    jobId: widget.jobId,
                    serviceId: serviceType,
                    jobTitle: jobTitle,
                    jobDescription: jobDescription,
                    jobStartDate: DateFormat('yyyy-MM-dd').format(jobStartDate),
                    jobEndDate: DateFormat('yyyy-MM-dd').format(jobEndDate),
                    jobStartTime: DateFormat('HH:mm').format(jobStartTime),
                    jobEndTime: DateFormat('HH:mm').format(jobEndTime),
                    jobType: jobType,
                    livingArrangement: livingArrangement ?? '');

                await jobPostsController.reloadJobPosts(uuid ?? '');
                jobPostsController.jobPosts.refresh();

                Get.to(() => const EmployerDashboardScreen(
                      initialPage: EmployerDashboardSections.posts,
                    ));
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
          ),
        ),
      ),
    );
  }

  List<Step> getsteps() => [
        Step(
          state: currentStep >= 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text(""),
          content: Column(
            children: [
              Text(
                "What care do you need?",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              CustomRadioListTile(
                title: 'Child Care',
                value: '1',
                groupValue: serviceType,
                onChanged: handleCareChange,
                image: const AssetImage(childCare),
              ),
              CustomRadioListTile(
                title: 'Elder Care',
                value: '2',
                groupValue: serviceType,
                onChanged: handleCareChange,
                image: const AssetImage(elderCare),
              ),
              CustomRadioListTile(
                title: 'Pet Care',
                value: '3',
                groupValue: serviceType,
                onChanged: handleCareChange,
                image: const AssetImage(petCare),
              ),
              CustomRadioListTile(
                title: 'House Services',
                value: '4',
                groupValue: serviceType,
                onChanged: handleCareChange,
                image: const AssetImage(houseServices),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep >= 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text(""),
          content: Column(
            children: [
              Text(
                "What job type do you need?",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              CustomRadioListTile(
                title: 'Full Time',
                value: 'full-time',
                groupValue: jobType,
                onChanged: handleTypeChange,
                image: const AssetImage(clock),
              ),
              CustomRadioListTile(
                title: 'Part Time',
                value: 'part-time',
                groupValue: jobType,
                onChanged: handleTypeChange,
                image: const AssetImage(clock),
              ),
              CustomRadioListTile(
                title: 'Temporary',
                value: 'temporary',
                groupValue: jobType,
                onChanged: handleTypeChange,
                image: const AssetImage(clock),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep >= 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text(""),
          content: Column(
            children: [
              Text(
                "What dates do you need Care?",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              DateRangePickerWidget(
                selectedStartDate:
                    DateFormat('yyyy-MM-dd').parse(jobStartDate.toString()),
                selectedEndDate:
                    DateFormat('yyyy-MM-dd').parse(jobEndDate.toString()),
                onStartDateSelected: (date) {
                  setState(() {
                    jobStartDate = date;
                  });
                },
                onEndDateSelected: (date) {
                  setState(() {
                    jobEndDate = date;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Time Pickers
              TimeRangePickerWidget(
                  selectedStartTime: jobStartTime,
                  selectedEndTime: jobEndTime,
                  onStartTimeSelected: (time) {
                    setState(() {
                      jobStartTime = time;
                    });
                  },
                  onEndTimeSelected: (time) {
                    setState(() {
                      jobEndTime = time;
                    });
                  }),

              const SizedBox(height: 20),
              LivingArrangementsWidget(
                selectedArrangementName: livingArrangement ?? '',
                onChanged: (value) {
                  setState(() {
                    livingArrangement = value;
                  });
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        Step(
          state: currentStep >= 4 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text(""),
          content: Column(
            children: [
              Text(
                "Describe the Job",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: jobTitleController,
                decoration: InputDecoration(
                  labelText: "Job Title",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Enter Job Title',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    jobTitle = value;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: jobDescriptionController,
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: "Job Description",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  hintText: 'Enter Job Description',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    jobDescription = value;
                  });
                },
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ];
  void handleCareChange(String value) {
    setState(() {
      serviceType = value;
    });
  }

  void handleTypeChange(String value) {
    setState(() {
      jobType = value;
    });
  }
}
