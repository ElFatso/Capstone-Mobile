import 'package:flutter/material.dart';

class SingleTimePickerWidget extends StatefulWidget {
  final DateTime selectedScheduleTime;
  final Function(DateTime) onScheduleTimeSelected;

  const SingleTimePickerWidget({
    Key? key,
    required this.selectedScheduleTime,
    required this.onScheduleTimeSelected,
  }) : super(key: key);

  @override
  SingleTimePickerWidgetState createState() => SingleTimePickerWidgetState();
}

class SingleTimePickerWidgetState extends State<SingleTimePickerWidget> {
  late DateTime selectedTime; // Added a local variable to track selected time

  @override
  void initState() {
    super.initState();
    selectedTime = widget.selectedScheduleTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: selectScheduleTime,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Schedule Time',
              border: OutlineInputBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  formatTime(selectedTime),
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

  Future<void> selectScheduleTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay.fromDateTime(selectedTime), // Use the local variable
    );
    if (picked != null) {
      final newScheduleTime = DateTime(
        selectedTime.year,
        selectedTime.month,
        selectedTime.day,
        picked.hour,
        picked.minute,
      );
      setState(() {
        selectedTime = newScheduleTime; // Update the local variable
      });
      widget.onScheduleTimeSelected(newScheduleTime);
    }
  }
}
