import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/constants/image_strings.dart';
import 'package:kasambahayko/src/constants/sizes.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';

class HomePage extends StatelessWidget {
  final Function(EmployerDashboardSections) onSectionSelected;
  const HomePage({
    super.key,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final userInfo = Get.find<UserInfoController>().userInfo;
    final firstName = userInfo['firstName']?.toString();
    double imageHeight = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(defaultpadding),
          child: Column(
            children: [
              Text(
                "Welcome, $firstName!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "What would you like to do today?",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 24,
              ),
              CarouselSlider(
                items: [
                  // Carousel item 1
                  Column(
                    children: [
                      Image.asset(
                        jobOfferImage,
                        height: imageHeight,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onSectionSelected(EmployerDashboardSections.search);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        child: const Text("Browse Workers",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      )
                    ],
                  ),

                  // Carousel item 2
                  Column(
                    children: [
                      Image.asset(
                        jobsOverviewImage,
                        height: imageHeight,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onSectionSelected(EmployerDashboardSections.posts);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        child: const Text("Manage Jobs",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      )
                    ],
                  ),

                  // Carousel item 3
                  Column(
                    children: [
                      Image.asset(
                        bookWorkerImage,
                        height: imageHeight,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onSectionSelected(EmployerDashboardSections.bookings);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        child: const Text("Book a Worker",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      )
                    ],
                  ),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 1 / 1,
                  enlargeCenterPage: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
