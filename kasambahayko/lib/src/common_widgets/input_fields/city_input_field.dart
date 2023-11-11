import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<Map<String, dynamic>> loadJsonData() async {
  final jsonString =
      await rootBundle.loadString('assets/data/region-viii.json');
  final jsonData = json.decode(jsonString);
  return jsonData;
}

class CityInputField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;

  const CityInputField({
    Key? key,
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  CityInputFieldState createState() => CityInputFieldState();
}

class CityInputFieldState extends State<CityInputField> {
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: loadJsonData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final municipalityList = snapshot.data?['LEYTE']['municipality_list']
              as Map<String, dynamic>;

          final cities = municipalityList.keys.toList();

          return DropdownButtonFormField<String>(
            value: selectedCity,
            onChanged: (String? newValue) {
              setState(() {
                selectedCity = newValue;
              });
              widget.onChanged(newValue!);
            },
            items: cities.map((String city) {
              return DropdownMenuItem<String>(
                value: city,
                child: SizedBox(
                  width: 200,
                  child: Text(
                    city,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Select your city',
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              border: const OutlineInputBorder(),
            ),
          );
        }
      },
    );
  }
}
