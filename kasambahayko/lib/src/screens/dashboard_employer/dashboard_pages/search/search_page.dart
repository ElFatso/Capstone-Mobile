import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/card/custom_card.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/highlight.dart';
import 'package:kasambahayko/src/common_widgets/highlight_text/highlighted.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';
import 'package:kasambahayko/src/controllers/search/worker_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/search/filter_page.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/search/worker_details.dart';

class SearchPage extends StatelessWidget {
  final uuid = Get.find<UserInfoController>().userInfo['uuid']?.toString();

  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: defaultpadding, left: defaultpadding, right: defaultpadding),
      child: Scaffold(
        body: GetBuilder<WorkerController>(
          init: WorkerController(),
          builder: (controller) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 12,
                    top: 12,
                  ),
                  child: CustomCard(
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
                            () => FilterPage(
                              selectedServiceNames:
                                  controller.selectedServiceNames,
                              selectedDocuments: controller.selectedDocuments,
                            ),
                            transition: Transition.upToDown,
                          );
                        },
                        child: const Text('Filter Workers'),
                      ),
                    ),
                  ),
                ),
                if (controller.isLoading.value)
                  const Center(child: CircularProgressIndicator())
                else if (controller.error.isNotEmpty)
                  Center(child: Text('Error: ${controller.error}'))
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredWorkers.length,
                      itemBuilder: (context, index) {
                        final worker = controller.filteredWorkers[index];
                        final profileUrl = worker['profile_url'];
                        final firstName = worker['first_name'];
                        final lastName = worker['last_name'];
                        final rate = worker['hourly_rate'];
                        final city = worker['city_municipality'];
                        final verification = worker['is_verified'];
                        final bio = worker['bio'];
                        final distance = worker['distance'].toString();
                        final availability = worker['availability'];
                        final servicesList = worker['services'];
                        final languagesList = worker['languages'];
                        final experience = worker['work_experience'];
                        final documents = worker['documents'];

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$firstName $lastName',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          '₱$rate/hr',
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
                                Text(
                                  '$city - $distance kilometers away',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Divider(
                                  color: greycolor,
                                  thickness: 1,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      const Icon(
                                        Icons.star_border,
                                        size: 32.0,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (verification == 'true')
                                      const Highlight(
                                        label: 'Badges:',
                                        highlightColor: greencolor,
                                        text: 'Verified',
                                      ),
                                    if (verification == 'false')
                                      const Highlight(
                                        label: 'Badges:',
                                        highlightColor: yellowcolor,
                                        text: 'Unverified',
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Text(
                                      'Services:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Highlighted(
                                      servicesList: servicesList,
                                      highlightColor: orangecolor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bio,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  onPressed: () {
                                    Get.to(
                                        () => WorkerDetailsScreen(
                                              profileUrl: profileUrl,
                                              lastName: lastName,
                                              firstName: firstName,
                                              rate: rate,
                                              city: city,
                                              verified: verification,
                                              bio: bio,
                                              availability: availability,
                                              distance: distance,
                                              experience: experience,
                                              servicesList: servicesList,
                                              languagesList: languagesList,
                                              documents: documents,
                                            ),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: const Text('View Profile'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
