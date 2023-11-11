import 'package:flutter/material.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_drawer.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/bookings_page.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/home_page.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/job_listings_page/listings_page.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/messaging_page.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/notifications_page.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/profile_page/profile.page.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/reviews_page.dart';
import 'package:kasambahayko/src/screens/dashboard_worker/dashboard_pages/settings_page.dart';
import 'package:kasambahayko/src/utils/theme_worker.dart';

class WorkerDashboardScreen extends StatefulWidget {
  final WorkerDashboardSections initialPage;

  const WorkerDashboardScreen({
    Key? key,
    required this.initialPage,
  }) : super(key: key);

  @override
  WorkerDashboardScreenState createState() => WorkerDashboardScreenState();
}

class WorkerDashboardScreenState extends State<WorkerDashboardScreen> {
  late WorkerDashboardSections currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
  }

  void navigateToPage(WorkerDashboardSections section) {
    setState(() {
      currentPage = section;
    });
    Navigator.pop(context);
  }

  void goToPage(WorkerDashboardSections section) {
    setState(() {
      currentPage = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget contentWidget;
    switch (currentPage) {
      case WorkerDashboardSections.home:
        contentWidget = HomePage(
          onSectionSelected: goToPage,
        );
        break;
      case WorkerDashboardSections.ratings:
        contentWidget = const RatingsPage();
        break;
      case WorkerDashboardSections.listings:
        contentWidget = ListingsPage();
        break;
      case WorkerDashboardSections.bookings:
        contentWidget = const BookingsPage();
        break;
      case WorkerDashboardSections.notifications:
        contentWidget = const NotificationsPage();
        break;
      case WorkerDashboardSections.messaging:
        contentWidget = const MessagingPage();
        break;
      case WorkerDashboardSections.profile:
        contentWidget = const ProfilePage();
        break;
      case WorkerDashboardSections.settings:
        contentWidget = const SettingsPage();
        break;
      case WorkerDashboardSections.logout:
        contentWidget = const SettingsPage();
    }

    return Theme(
      data: WorkerTheme.theme,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: secondarycolor,
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
      ),
    );
  }
}
