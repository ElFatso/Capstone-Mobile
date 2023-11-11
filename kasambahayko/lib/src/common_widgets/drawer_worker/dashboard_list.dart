import 'package:flutter/material.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_drawer.dart';
import 'package:kasambahayko/src/common_widgets/drawer_worker/dashboard_sections.dart';

class DrawerList extends StatelessWidget {
  final WorkerDashboardSections currentPage;
  final Function(WorkerDashboardSections) onMenuItemTap;

  const DrawerList({
    super.key,
    required this.currentPage,
    required this.onMenuItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildMenuItem(
            WorkerDashboardSections.home,
            "Home",
            Icons.dashboard_outlined,
            currentPage == WorkerDashboardSections.home,
            onMenuItemTap),
        buildMenuItem(
            WorkerDashboardSections.ratings,
            "Ratings",
            Icons.rate_review_outlined,
            currentPage == WorkerDashboardSections.ratings,
            onMenuItemTap),
        buildMenuItem(
            WorkerDashboardSections.listings,
            "Job Listings",
            Icons.list_alt,
            currentPage == WorkerDashboardSections.listings,
            onMenuItemTap),
        buildMenuItem(
            WorkerDashboardSections.bookings,
            "Bookings",
            Icons.calendar_today_outlined,
            currentPage == WorkerDashboardSections.bookings,
            onMenuItemTap),
        const Divider(),
        buildMenuItem(
            WorkerDashboardSections.notifications,
            "Notifications",
            Icons.notifications_outlined,
            currentPage == WorkerDashboardSections.notifications,
            onMenuItemTap),
        buildMenuItem(
            WorkerDashboardSections.messaging,
            "Messaging",
            Icons.message_outlined,
            currentPage == WorkerDashboardSections.messaging,
            onMenuItemTap),
        const Divider(),
        buildMenuItem(
          WorkerDashboardSections.profile,
          "Profile",
          Icons.person_outline,
          currentPage == WorkerDashboardSections.profile,
          onMenuItemTap,
        ),
        buildMenuItem(
            WorkerDashboardSections.settings,
            "Settings",
            Icons.settings_outlined,
            currentPage == WorkerDashboardSections.settings,
            onMenuItemTap),
      ],
    );
  }
}
