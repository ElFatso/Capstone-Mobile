import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/job_listings/job_listings_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_screen.dart';
import 'package:kasambahayko/src/utils/theme_worker.dart';

enum SortOrder {
  ascending,
  descending,
  none,
}

enum ServiceType {
  childCare,
  elderCare,
  petCare,
  houseServices,
  none,
}

enum LivingArrangement {
  liveInWithOwnQuarters,
  liveInWithSharedQuarters,
  liveInWithSeparateEntrance,
  liveOutWithOwnTransportation,
  liveOutWithStipend,
  liveOutWithSharedQuarters,
  none,
}

ServiceType stringToServiceType(String value) {
  switch (value) {
    case 'Child Care':
      return ServiceType.childCare;
    case 'Elder Care':
      return ServiceType.elderCare;
    case 'Pet Care':
      return ServiceType.petCare;
    case 'House Services':
      return ServiceType.houseServices;
    default:
      return ServiceType.none;
  }
}

String serviceTypeToString(ServiceType serviceType) {
  switch (serviceType) {
    case ServiceType.childCare:
      return 'Child Care';
    case ServiceType.elderCare:
      return 'Elder Care';
    case ServiceType.petCare:
      return 'Pet Care';
    case ServiceType.houseServices:
      return 'House Services';
    default:
      return 'None';
  }
}

LivingArrangement stringToLivingArrangement(String value) {
  switch (value) {
    case 'Live-in with own quarters':
      return LivingArrangement.liveInWithOwnQuarters;
    case 'Live-in with shared quarters':
      return LivingArrangement.liveInWithSharedQuarters;
    case 'Live-in with separate entrance':
      return LivingArrangement.liveInWithSeparateEntrance;
    case 'Live-out with own transportation':
      return LivingArrangement.liveOutWithOwnTransportation;
    case 'Live-out with stipend':
      return LivingArrangement.liveOutWithStipend;
    case 'Live-out with shared quarters':
      return LivingArrangement.liveOutWithSharedQuarters;
    default:
      return LivingArrangement.none;
  }
}

String livingArrangementToString(LivingArrangement livingArrangement) {
  switch (livingArrangement) {
    case LivingArrangement.liveInWithOwnQuarters:
      return 'Live-in with own quarters';
    case LivingArrangement.liveInWithSharedQuarters:
      return 'Live-in with shared quarters';
    case LivingArrangement.liveInWithSeparateEntrance:
      return 'Live-in with separate entrance';
    case LivingArrangement.liveOutWithOwnTransportation:
      return 'Live-out with own transportation';
    case LivingArrangement.liveOutWithStipend:
      return 'Live-out with stipend';
    case LivingArrangement.liveOutWithSharedQuarters:
      return 'Live-out with shared quarters';
    default:
      return 'None';
  }
}

class FilterListings extends StatefulWidget {
  final String selectedServiceName;
  final String selectedLivingArrangement;

  const FilterListings({
    Key? key,
    required this.selectedServiceName,
    required this.selectedLivingArrangement,
  }) : super(key: key);

  @override
  FilterListingsState createState() => FilterListingsState();
}

class FilterListingsState extends State<FilterListings> {
  SortOrder distanceSortOrder = SortOrder.none;
  SortOrder postDateSortOrder = SortOrder.none;
  String selectedServiceName = serviceTypeToString(ServiceType.none);
  String selectedLivingArrangement =
      livingArrangementToString(LivingArrangement.none);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: WorkerTheme.theme,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton<ServiceType>(
                            value: stringToServiceType(selectedServiceName),
                            onChanged: (ServiceType? newValue) {
                              setState(() {
                                selectedServiceName = serviceTypeToString(
                                    newValue ?? ServiceType.none);
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: ServiceType.none,
                                child: Text("None",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value: ServiceType.childCare,
                                child: Text("Child Care",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value: ServiceType.elderCare,
                                child: Text("Elder Care",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value: ServiceType.petCare,
                                child: Text("Pet Care",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value: ServiceType.houseServices,
                                child: Text("House Services",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Work Arrangement",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DropdownButton<LivingArrangement>(
                            value: stringToLivingArrangement(
                                selectedLivingArrangement),
                            onChanged: (LivingArrangement? newValue) {
                              setState(() {
                                selectedLivingArrangement =
                                    livingArrangementToString(
                                        newValue ?? LivingArrangement.none);
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                value: LivingArrangement.none,
                                child: Text("None",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value: LivingArrangement.liveInWithOwnQuarters,
                                child: Text("Live-in with own quarters",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value:
                                    LivingArrangement.liveInWithSharedQuarters,
                                child: Text("Live-in with shared quarters",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value: LivingArrangement
                                    .liveInWithSeparateEntrance,
                                child: Text("Live-in with separate entrance",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value: LivingArrangement
                                    .liveOutWithOwnTransportation,
                                child: Text("Live-out with own transportation",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value: LivingArrangement.liveOutWithStipend,
                                child: Text("Live-out with stipend",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                              DropdownMenuItem(
                                value:
                                    LivingArrangement.liveOutWithSharedQuarters,
                                child: Text("Live-out with shared quarters",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ],
                          )
                        ],
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
                          Text("Post Date",
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton<SortOrder>(
                                value: postDateSortOrder,
                                onChanged: (SortOrder? newValue) {
                                  setState(() {
                                    postDateSortOrder =
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
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () {
                    final listingController = Get.find<JobListingsController>();
                    final selectedName = selectedServiceName;
                    final selectedArrangement = selectedLivingArrangement;
                    listingController.applyFilters(
                        selectedName, selectedArrangement);
                    if (distanceSortOrder != SortOrder.none) {
                      listingController.sortListingsByDistance(
                          distanceSortOrder == SortOrder.ascending);
                    } else if (postDateSortOrder != SortOrder.none) {
                      listingController.sortListingsByJobPostingDate(
                          postDateSortOrder == SortOrder.ascending);
                    }
                    Get.to(() => const WorkerDashboardScreen(
                          initialPage: WorkerDashboardSections.listings,
                        ));
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
