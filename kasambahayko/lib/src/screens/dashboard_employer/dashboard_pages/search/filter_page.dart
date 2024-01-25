import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/search/worker_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';
import 'package:multiselect/multiselect.dart';

enum SortOrder {
  ascending,
  descending,
  none,
}

class FilterPage extends StatefulWidget {
  final List<String> selectedServiceNames;
  final List<String> selectedDocuments;

  const FilterPage({
    Key? key,
    required this.selectedServiceNames,
    required this.selectedDocuments,
  }) : super(key: key);

  @override
  FilterPageState createState() => FilterPageState();
}

class FilterPageState extends State<FilterPage> {
  SortOrder distanceSortOrder = SortOrder.none;
  SortOrder payRateSortOrder = SortOrder.none;

  final List<String> availableServiceNames = [
    'Child Care',
    'Elder Care',
    'Pet Care',
    'House Services',
  ];

  List<String> selectedServiceNames = [];

  final List<String> availableDocuments = [
    'resume',
    'barangay clearance',
    'police clearance',
    'nbi clearance',
  ];

  List<String> selectedDocuments = [];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: EmployerTheme.theme,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
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
                        "Service Categories",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      DropDownMultiSelect(
                        options: availableServiceNames,
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        selectedValues: widget.selectedServiceNames,
                        onChanged: (selectedItems) {
                          setState(() {
                            selectedServiceNames = selectedItems.cast<String>();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Select Service Categories",
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Document Availability",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      DropDownMultiSelect(
                        options: availableDocuments,
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        selectedValues: widget.selectedDocuments,
                        onChanged: (selectedItems) {
                          setState(() {
                            selectedDocuments = selectedItems.cast<String>();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Select Document Availability",
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                          border: const OutlineInputBorder(),
                        ),
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
                    final selectedNames = widget.selectedServiceNames.toList();
                    final selectedDocuments = widget.selectedDocuments.toList();
                    final workerController = Get.find<WorkerController>();
                    workerController.selectedServiceNames
                        .assignAll(selectedNames);
                    workerController.selectedDocuments
                        .assignAll(selectedDocuments);
                    workerController.applyCombinedFilter();

                    if (payRateSortOrder != SortOrder.none) {
                      workerController.sortWorkersByPayRate(
                          payRateSortOrder == SortOrder.ascending);
                    } else if (distanceSortOrder != SortOrder.none) {
                      workerController.sortWorkersByDistance(
                          distanceSortOrder == SortOrder.ascending);
                    }
                    Get.to(() => const EmployerDashboardScreen(
                          initialPage: EmployerDashboardSections.search,
                        ));
                    log(selectedNames.toString());
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
