import 'package:flutter/material.dart';

class SingleItemDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final InputDecoration? decoration;
  final bool enabled;

  const SingleItemDropdown({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    this.decoration,
    this.enabled = true,
  }) : super(key: key);

  @override
  SingleItemDropdownState createState() => SingleItemDropdownState();
}

class SingleItemDropdownState extends State<SingleItemDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedItem,
      onChanged: widget.enabled ? widget.onChanged : null,
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }).toList(),
      decoration: widget.decoration ??
          const InputDecoration(
            labelText: "",
            border: OutlineInputBorder(),
          ),
    );
  }
}
