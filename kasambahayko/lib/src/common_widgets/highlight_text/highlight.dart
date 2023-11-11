import 'package:flutter/material.dart';

class Highlight extends StatelessWidget {
  final String label;
  final String text;
  final Color highlightColor;
  final double borderRadius;
  final double padding;

  const Highlight({
    Key? key,
    required this.label,
    required this.text,
    required this.highlightColor,
    this.borderRadius = 4.0,
    this.padding = 6.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: highlightColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      );
    } else {
      return Text(
        label,
        style: Theme.of(context).textTheme.bodySmall,
      );
    }
  }
}
