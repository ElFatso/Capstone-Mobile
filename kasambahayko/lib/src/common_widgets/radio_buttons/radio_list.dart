import 'package:flutter/material.dart';
import 'package:kasambahayko/src/constants/colors.dart';

class CustomRadioListTile extends StatelessWidget {
  final String title;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final ImageProvider image;

  const CustomRadioListTile({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onChanged(value);
        }
      },
      child: Container(
        padding:
            isSelected ? const EdgeInsets.all(8.0) : const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? primarycolor : Colors.transparent,
            width: 4.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: 0.3, // Adjust this value as needed
              child: Image(
                image: image,
                fit: BoxFit
                    .contain, // Maintain aspect ratio and fit within the box
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? primarycolor : blackcolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
