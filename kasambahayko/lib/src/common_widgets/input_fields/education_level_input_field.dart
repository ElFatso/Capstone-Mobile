import 'package:flutter/material.dart';

enum EducationLevel {
  highSchool,
  college,
  vocational,
  postGraduate,
}

EducationLevel? stringToEducationLevel(String? educationLevelString) {
  switch (educationLevelString) {
    case "High School":
      return EducationLevel.highSchool;
    case "College":
      return EducationLevel.college;
    case "Vocational":
      return EducationLevel.vocational;
    case "Post Graduate":
      return EducationLevel.postGraduate;
    default:
      return null;
  }
}

String? educationLevelToString(EducationLevel? educationLevel) {
  if (educationLevel != null) {
    switch (educationLevel) {
      case EducationLevel.highSchool:
        return "High School";
      case EducationLevel.college:
        return "College";
      case EducationLevel.vocational:
        return "Vocational";
      case EducationLevel.postGraduate:
        return "Post Graduate";
    }
  }
  return null;
}

class EducationLevelWidget extends StatelessWidget {
  final EducationLevel? selectedLevel;
  final ValueChanged<EducationLevel?> onChanged;
  final bool enabled;

  const EducationLevelWidget({
    Key? key,
    required this.selectedLevel,
    required this.onChanged,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          readOnly: true,
          controller: TextEditingController(
              text: educationLevelToString(selectedLevel)),
          onTap: () {
            showEducationLevelPicker(context);
          },
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            label: const Text("Select an Education Level"),
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            border: const OutlineInputBorder(),
          ),
          enabled: enabled,
        ),
      ],
    );
  }

  void showEducationLevelPicker(BuildContext context) {
    const List<EducationLevel> educationLevels = EducationLevel.values;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select an Education Level",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: educationLevels.map((level) {
              return ListTile(
                title: Text(
                  educationLevelToString(level)!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  onChanged(level);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
