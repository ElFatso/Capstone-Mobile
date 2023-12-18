import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/application_process/applicants_controller.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';

enum SortOrder {
  ascending,
  descending,
  none,
}

class ApplicantsFilter extends StatefulWidget {
  final RxInt top;
  const ApplicantsFilter({
    Key? key,
    required this.top,
  }) : super(key: key);

  @override
  ApplicantsFilterState createState() => ApplicantsFilterState();
}

class ApplicantsFilterState extends State<ApplicantsFilter> {
  SortOrder distanceSortOrder = SortOrder.none;
  SortOrder payRateSortOrder = SortOrder.none;
  int top = 0;
  TextEditingController topController = TextEditingController();
  final int totalApplicants =
      Get.find<JobApplicantsController>().totalApplicants.length;

  @override
  void initState() {
    super.initState();
    topController.text = widget.top.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: EmployerTheme.theme,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(defaultpadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24, left: 24),
                  child: Column(
                    children: [
                      Text(
                        "Filters",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Divider(
                        color: greycolor,
                        thickness: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Select Top",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        controller: topController,
                        decoration: InputDecoration(
                          labelText: "Hourly Rate",
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                          hintText: 'Hourly Rate',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          border: const OutlineInputBorder(),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.keyboard_arrow_up),
                                onPressed: () {
                                  setState(() {
                                    widget.top.value = (widget.top.value + 1)
                                        .clamp(0, totalApplicants);
                                    topController.text =
                                        widget.top.value.toString();
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.keyboard_arrow_down),
                                onPressed: () {
                                  setState(() {
                                    widget.top.value = (widget.top.value - 1)
                                        .clamp(0, totalApplicants);
                                    topController.text =
                                        widget.top.value.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Sort By",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Divider(
                        color: greycolor,
                        thickness: 1,
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          Text("Distance",
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton<SortOrder>(
                                value: distanceSortOrder,
                                onChanged: (SortOrder? newValue) {
                                  setState(() {
                                    distanceSortOrder =
                                        newValue ?? SortOrder.none;
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                    value: SortOrder.none,
                                    child: Text("None",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                  DropdownMenuItem(
                                    value: SortOrder.ascending,
                                    child: Text("Ascending",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                  DropdownMenuItem(
                                    value: SortOrder.descending,
                                    child: Text("Descending",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text("Pay Rate",
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton<SortOrder>(
                                value: payRateSortOrder,
                                onChanged: (SortOrder? newValue) {
                                  setState(() {
                                    payRateSortOrder =
                                        newValue ?? SortOrder.none;
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                    value: SortOrder.none,
                                    child: Text("None",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                  DropdownMenuItem(
                                    value: SortOrder.ascending,
                                    child: Text("Ascending",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                  DropdownMenuItem(
                                    value: SortOrder.descending,
                                    child: Text("Descending",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    final applicantController =
                        Get.find<JobApplicantsController>();

                    if (payRateSortOrder != SortOrder.none) {
                      applicantController.sortApplicantsByPayRate(
                          payRateSortOrder == SortOrder.ascending);
                    } else if (distanceSortOrder != SortOrder.none) {
                      applicantController.sortApplicantsByDistance(
                          distanceSortOrder == SortOrder.ascending);
                    }
                    final top = int.parse(topController.text);
                    applicantController.getTopApplicants();
                    applicantController.setTopCount(top);
                    Get.back();
                  },
                  child: const Text('Apply Filters'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
