import 'package:flutter/material.dart';

class CombinedTile extends StatelessWidget {
  final String title;
  final VoidCallback onRemove;
  final TextEditingController controller;
  final VoidCallback onAdd;

  const CombinedTile({
    super.key,
    required this.title,
    required this.onRemove,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Text(title),
          trailing: ElevatedButton(
            onPressed: onRemove,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Icon(Icons.remove),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
