import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/common_widgets/input_fields/single_item_dropdown.dart';
import 'package:kasambahayko/src/common_widgets/picker/date_picker/date_picker.dart';
import 'package:kasambahayko/src/common_widgets/picker/time_picker/time_picker.dart';
import 'package:kasambahayko/src/common_widgets/radio_buttons/radio_list.dart';
import 'package:kasambahayko/src/constants/image_strings.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/create_post_controller.dart';
import 'package:kasambahayko/src/controllers/post_creation/job_post_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  CreatePostScreenState createState() => CreatePostScreenState();
}

class CreatePostScreenState extends State<CreatePostScreen> {
  int currentStep = 0;
  final uuid = Get.find<UserInfoController>().userInfo['uuid'].toString();
  String serviceId = '';
  String jobType = '';
  DateTime jobStartDate = DateTime.now();
  DateTime jobEndDate = DateTime.now();
  DateTime jobStartTime = DateTime.now();
  DateTime jobEndTime = DateTime.now();
  String? selectedLivingArrangement = 'Live-in with own quarters';
  final List<String> availableLivingArrangement = [
    'Live-in with own quarters',
    'Live-in with shared quarters',
    'Live-in with separate entrance',
    'Live-out with own transportation',
    'Live-out with stipend',
  ];
  String jobTitle = '';
  String jobDescription = '';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: EmployerTheme.theme,
      child: Scaffold(
        body: SafeArea(
          child: Stepper(
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
                    if (currentStep != 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controlsDetails.onStepCancel,
                          child: const Text('BACK'),
                        ),
                      ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controlsDetails.onStepContinue,
                        child: Text(lastStep ? 'CONFIRM' : 'NEXT'),
                      ),
                    ),
                  ],
                ),
              );
            },
            onStepContinue: () async {
              final isLastStep = currentStep == getsteps().length - 1;

              if (isLastStep) {
                final createPostController = Get.find<CreatePostController>();
                final jobPostsController = Get.find<JobPostsController>();

                await createPostController.createJobPost(
                  uuid,
                  serviceId,
                  jobTitle,
                  jobDescription,
                  jobType,
                  DateFormat('yyyy-MM-dd').format(jobStartDate),
                  DateFormat('yyyy-MM-dd').format(jobEndDate),
                  DateFormat('HH:mm').format(jobStartTime),
                  DateFormat('HH:mm').format(jobEndTime),
                  selectedLivingArrangement ?? '',
                );

                await jobPostsController.reloadJobPosts(uuid);
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
                groupValue: serviceId,
                onChanged: handleCareChange,
                image: const AssetImage(childCare),
              ),
              CustomRadioListTile(
                title: 'Elder Care',
                value: '2',
                groupValue: serviceId,
                onChanged: handleCareChange,
                image: const AssetImage(elderCare),
              ),
              CustomRadioListTile(
                title: 'Pet Care',
                value: '3',
                groupValue: serviceId,
                onChanged: handleCareChange,
                image: const AssetImage(petCare),
              ),
              CustomRadioListTile(
                title: 'House Services',
                value: '4',
                groupValue: serviceId,
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
                selectedStartDate: jobStartDate,
                selectedEndDate: jobEndDate,
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
              SingleItemDropdown(
                items: availableLivingArrangement,
                selectedItem: selectedLivingArrangement,
                onChanged: (value) {
                  setState(() {
                    selectedLivingArrangement = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Payment Frequency",
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                ),
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
                minLines: 1,
                maxLines: null,
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
              ),
              const SizedBox(height: 16),
              TextFormField(
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
              ),
            ],
          ),
        ),
      ];
  void handleCareChange(String value) {
    setState(() {
      serviceId = value;
    });
  }

  void handleTypeChange(String value) {
    setState(() {
      jobType = value;
    });
  }
}
