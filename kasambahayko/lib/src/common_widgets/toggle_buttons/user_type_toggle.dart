import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:kasambahayko/src/constants/colors.dart';

class UserTypeToggle extends StatefulWidget {
  final ValueChanged<String> onUserTypeChanged;

  const UserTypeToggle(
      {super.key,
      required this.onUserTypeChanged,
      required String initialUserType});

  @override
  UserTypeToggleState createState() => UserTypeToggleState();
}

class UserTypeToggleState extends State<UserTypeToggle> {
  String userType = "household employer";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: Column(
        children: [
          FlutterToggleTab(
            width: width * 0.15,
            borderRadius: 30,
            selectedIndex: userType == "household employer" ? 0 : 1,
            selectedTextStyle: const TextStyle(color: whitecolor),
            selectedBackgroundColors: const [blackcolor],
            unSelectedTextStyle: const TextStyle(color: blackcolor),
            labels: const ["Employer", "Worker"],
            selectedLabelIndex: (index) {
              setState(() {
                userType =
                    index == 0 ? "household employer" : "domestic worker";
                widget.onUserTypeChanged(userType);
              });
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
