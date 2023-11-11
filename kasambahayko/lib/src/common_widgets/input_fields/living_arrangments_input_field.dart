import 'package:flutter/material.dart';

class LivingArrangementsWidget extends StatelessWidget {
  final List<Map<String, String>> livingArrangements;
  final String? selectedArrangementName; // Use name instead of code
  final ValueChanged<String?> onChanged;

  const LivingArrangementsWidget({
    Key? key,
    required this.selectedArrangementName, // Use name instead of code
    required this.onChanged,
    this.livingArrangements = const [
      {
        'optName': 'Live-in with own quarters',
        'code': 'li-oquart',
      },
      {
        'optName': 'Live-in with shared quarters',
        'code': 'li-shquart',
      },
      {
        'optName': 'Live-in with separate entrance',
        'code': 'li-sepent',
      },
      {
        'optName': 'Live-out with own transportation',
        'code': 'lo-transport',
      },
      {
        'optName': 'Live-out with stipend',
        'code': 'lo-stip',
      },
      {
        'optName': 'Live-out with shared quarters',
        'code': 'lo-squarters',
      },
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Living Arrangement",
            style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 16),
        TextField(
          readOnly: true, // Make the TextField read-only
          controller: TextEditingController(text: selectedArrangementName),
          onTap: () {
            showLivingArrangementPicker(context);
          },
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            label: const Text("Select a Living Arrangement"),
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            border: const OutlineInputBorder(),
          ),
        )
      ],
    );
  }

  void showLivingArrangementPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select a Living Arrangement",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: livingArrangements.map((arrangement) {
              return ListTile(
                title: Text(
                  arrangement['optName']!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  Navigator.of(context).pop(); // Close the dialog
                  onChanged(arrangement[
                      'optName']); // Notify the selected value (name)
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

extension IterableExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
