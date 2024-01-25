import 'package:flutter/material.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_drawer.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';

class DrawerList extends StatelessWidget {
  final EmployerDashboardSections currentPage;
  final Function(EmployerDashboardSections) onMenuItemTap;

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
            EmployerDashboardSections.home,
            "Home",
            Icons.dashboard_outlined,
            currentPage == EmployerDashboardSections.home,
            onMenuItemTap),
        buildMenuItem(
            EmployerDashboardSections.search,
            "Search",
            Icons.search_outlined,
            currentPage == EmployerDashboardSections.search,
            onMenuItemTap),
        buildMenuItem(
            EmployerDashboardSections.posts,
            "Job Posts",
            Icons.post_add_outlined,
            currentPage == EmployerDashboardSections.posts,
            onMenuItemTap),
        buildMenuItem(
            EmployerDashboardSections.bookings,
            "Bookings",
            Icons.calendar_today_outlined,
            currentPage == EmployerDashboardSections.bookings,
            onMenuItemTap),
        const Divider(),
        buildMenuItem(
            EmployerDashboardSections.notifications,
            "Notifications",
            Icons.notifications_outlined,
            currentPage == EmployerDashboardSections.notifications,
            onMenuItemTap),
        buildMenuItem(
          EmployerDashboardSections.profile,
          "Profile",
          Icons.person_outline,
          currentPage == EmployerDashboardSections.profile,
          onMenuItemTap,
        ),
        buildMenuItem(
          EmployerDashboardSections.logout,
          "Logout",
          Icons.logout_outlined,
          currentPage == EmployerDashboardSections.logout,
          onMenuItemTap,
        ),
      ],
    );
  }
}
