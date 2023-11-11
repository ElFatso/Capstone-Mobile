import 'package:flutter/material.dart';

class TimeRangePickerWidget extends StatefulWidget {
  final DateTime selectedStartTime;
  final DateTime selectedEndTime;
  final Function(DateTime) onStartTimeSelected;
  final Function(DateTime) onEndTimeSelected;

  const TimeRangePickerWidget({
    Key? key,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.onStartTimeSelected,
    required this.onEndTimeSelected,
  }) : super(key: key);

  @override
  TimeRangePickerWidgetState createState() => TimeRangePickerWidgetState();
}

class TimeRangePickerWidgetState extends State<TimeRangePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: selectStartTime,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Job Starting Time',
              border: OutlineInputBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  formatTime(widget.selectedStartTime),
                ),
                const Icon(Icons.access_time),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: selectEndTime,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Job Ending Time',
              border: OutlineInputBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  formatTime(widget.selectedEndTime),
                ),
                const Icon(Icons.access_time),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formatTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<void> selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(widget.selectedStartTime),
    );
    if (picked != null) {
      final newStartTime = DateTime(
        widget.selectedStartTime.year,
        widget.selectedStartTime.month,
        widget.selectedStartTime.day,
        picked.hour,
        picked.minute,
      );
      widget.onStartTimeSelected(newStartTime);
    }
  }

  Future<void> selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(widget.selectedEndTime),
    );
    if (picked != null) {
      final newEndTime = DateTime(
        widget.selectedEndTime.year,
        widget.selectedEndTime.month,
        widget.selectedEndTime.day,
        picked.hour,
        picked.minute,
      );
      widget.onEndTimeSelected(newEndTime);
    }
  }
}
