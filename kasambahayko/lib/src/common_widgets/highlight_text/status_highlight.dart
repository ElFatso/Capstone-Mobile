import 'package:flutter/material.dart';

class StatusHighlight extends StatelessWidget {
  final String label;
  final String text;
  final Color highlightColor;
  final double borderRadius;
  final double padding;

  const StatusHighlight({
    Key? key,
    required this.label,
    required this.text,
    required this.highlightColor,
    this.borderRadius = 6.0,
    this.padding = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text.isNotEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
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
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }
  }
}
