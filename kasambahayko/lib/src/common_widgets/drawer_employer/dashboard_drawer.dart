import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_header.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_list.dart';
import 'package:kasambahayko/src/common_widgets/drawer_employer/dashboard_sections.dart';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/constants/sizes.dart';

class DashboardDrawer extends StatefulWidget {
  final EmployerDashboardSections currentPage;
  final Function(EmployerDashboardSections) onMenuItemTap;
  final File? selectedImage;

  const DashboardDrawer({
    super.key,
    required this.currentPage,
    required this.onMenuItemTap,
    this.selectedImage,
  });

  @override
  State<DashboardDrawer> createState() => DashboardDrawerState();
}

class DashboardDrawerState extends State<DashboardDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DashboardHeader(
              appBarHeight: 80,
            ),
            DrawerList(
                currentPage: widget.currentPage,
                onMenuItemTap: widget.onMenuItemTap),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem(EmployerDashboardSections section, String title,
    IconData icon, bool selected, Function onTap) {
  return Material(
    color: selected ? greycolor : Colors.transparent,
    child: InkWell(
      onTap: () {
        onTap(section);
      },
      child: Padding(
        padding: const EdgeInsets.all(defaultpadding),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 24,
                color: blackcolor,
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
