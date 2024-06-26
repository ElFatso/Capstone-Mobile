import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_drawer.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/login_controller.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/bookings_page/bookings_page.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/home_page.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/notifications_page.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/postings/application_review.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/postings/job_post_page.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/profile_page/profile.page.dart';
import 'package:kasambahayko/src/screens/dashboard_employer/dashboard_pages/search/search_page.dart';
import 'package:kasambahayko/src/screens/login/login_screen.dart';
import 'package:kasambahayko/src/utils/theme_employer.dart';

class EmployerDashboardScreen extends StatefulWidget {
  final EmployerDashboardSections initialPage;

  const EmployerDashboardScreen({
    Key? key,
    required this.initialPage,
  }) : super(key: key);

  @override
  EmployerDashboardScreenState createState() => EmployerDashboardScreenState();
}

class EmployerDashboardScreenState extends State<EmployerDashboardScreen> {
  late EmployerDashboardSections currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
  }

  void navigateToPage(EmployerDashboardSections section) {
    setState(() {
      if (section == EmployerDashboardSections.logout) {
        final loginController = Get.find<LoginController>();

        loginController.emailController.clear();
        loginController.passwordController.clear();

        // Delaying for 500 milliseconds (0.5 seconds)
        Future.delayed(const Duration(milliseconds: 200), () {
          Get.off(() => const LoginScreen());
        });
      } else {
        currentPage = section;
      }
    });
    Navigator.pop(context);
  }

  void goToPage(EmployerDashboardSections section) {
    setState(() {
      currentPage = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget;
    switch (currentPage) {
      case EmployerDashboardSections.home:
        contentWidget = HomePage(onSectionSelected: goToPage);
        break;
      case EmployerDashboardSections.search:
        contentWidget = SearchPage();
        break;
      case EmployerDashboardSections.posts:
        contentWidget = JobPostPage(onSectionSelected: goToPage);
        break;
      case EmployerDashboardSections.bookings:
        contentWidget = const BookingsPage();
        break;
      case EmployerDashboardSections.applications:
        contentWidget = const ApplicationsPage();
        break;
      case EmployerDashboardSections.notifications:
        contentWidget = const NotificationsPage();
        break;
      case EmployerDashboardSections.profile:
        contentWidget = const ProfilePage();
        break;
      case EmployerDashboardSections.logout:
        contentWidget = Container();
    }

    return Theme(
      data: EmployerTheme.theme,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: primarycolor,
          centerTitle: true,
          title: const Text(
            'KasambahayKo',
            textAlign: TextAlign.center,
          ),
        ),
        body: contentWidget,
        drawer: DashboardDrawer(
          currentPage: currentPage,
          onMenuItemTap: navigateToPage,
        ),
      ),
    );
  }
}
