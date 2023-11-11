import 'package:flutter/material.dart';

class BooleanMultiSelect extends StatefulWidget {
  final List<String> options;
  final List<int> selectedValues;
  final Function(List<int>) onChanged;
  final bool enabled;

  const BooleanMultiSelect({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.enabled = true, // Default to true if not provided
  });

  @override
  BooleanMultiSelectState createState() => BooleanMultiSelectState();
}

class BooleanMultiSelectState extends State<BooleanMultiSelect> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.options.map((option) {
        final bool isSelected =
            widget.selectedValues[widget.options.indexOf(option)] == 1;

        return Row(
          children: <Widget>[
            Text(option),
            Checkbox(
              value: isSelected,
              onChanged: widget.enabled
                  ? (bool? value) {
                      setState(() {
                        widget.selectedValues[widget.options.indexOf(option)] =
                            value == true ? 1 : 0;
                        widget.onChanged(widget.selectedValues);
                      });
                    }
                  : null,
            ),
          ],
        );
      }).toList(),
    );
  }
}
