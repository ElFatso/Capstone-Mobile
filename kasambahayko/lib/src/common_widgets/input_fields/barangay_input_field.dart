import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class BarangayInputField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? selectedCity;

  const BarangayInputField({
    Key? key,
    required this.onChanged,
    required this.selectedCity,
  }) : super(key: key);

  @override
  BarangayInputFieldState createState() => BarangayInputFieldState();
}

class BarangayInputFieldState extends State<BarangayInputField> {
  String? selectedBarangay;
  Map<String, dynamic>? jsonData;
  List<String> barangays = [];

  @override
  void initState() {
    super.initState();
    loadJsonData().then((data) {
      setState(() {
        jsonData = data;
        if (widget.selectedCity != null) {
          updateBarangays(widget.selectedCity!);
        }
      });
    });
  }

  Future<Map<String, dynamic>> loadJsonData() async {
    final jsonString =
        await rootBundle.loadString('assets/data/region-viii.json');
    return json.decode(jsonString);
  }

  void updateBarangays(String city) {
    final municipalityList =
        jsonData!['LEYTE']['municipality_list'] as Map<String, dynamic>;
    final selectedCityData = municipalityList[city];
    if (selectedCityData != null) {
      final barangayList = selectedCityData['barangay_list'] as List<dynamic>;
      setState(() {
        barangays = barangayList.cast<String>();
        selectedBarangay =
            null; // Reset selected barangay when the city changes
      });
    }
  }

  @override
  void didUpdateWidget(covariant BarangayInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCity != widget.selectedCity) {
      if (widget.selectedCity != null) {
        updateBarangays(widget.selectedCity!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      key: ValueKey(widget.selectedCity), // Use a ValueKey to trigger rebuild
      value: selectedBarangay,
      onChanged: (String? newValue) {
        setState(() {
          selectedBarangay = newValue;
        });
        widget.onChanged(newValue!);
      },
      items: barangays.map<DropdownMenuItem<String>>((barangay) {
        return DropdownMenuItem<String>(
          value: barangay,
          child: SizedBox(
            width: 200, // Adjust the width as needed
            child: Text(
              barangay,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis, // Add ellipsis for long texts
            ),
          ),
        );
      }).toList(),
      // Display an empty list if barangays is null
      decoration: InputDecoration(
        labelText: 'Select your barangay',
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
