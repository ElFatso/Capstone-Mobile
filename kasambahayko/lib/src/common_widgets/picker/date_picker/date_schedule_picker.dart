import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleDatePickerWidget extends StatefulWidget {
  final DateTime selectedScheduleDate;
  final Function(DateTime) onScheduleDateSelected;

  const SingleDatePickerWidget({
    Key? key,
    required this.selectedScheduleDate,
    required this.onScheduleDateSelected,
  }) : super(key: key);

  @override
  SingleDatePickerWidgetState createState() => SingleDatePickerWidgetState();
}

class SingleDatePickerWidgetState extends State<SingleDatePickerWidget> {
  late DateTime selectedScheduleDate;

  @override
  void initState() {
    super.initState();
    selectedScheduleDate = widget.selectedScheduleDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: selectScheduleDate,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Schedule Date',
              border: OutlineInputBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateFormat('yyyy-MM-dd').format(selectedScheduleDate),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> selectScheduleDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedScheduleDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedScheduleDate = DateFormat('yyyy-MM-dd').parse(
          DateFormat('yyyy-MM-dd').format(picked),
        );
      });
      widget.onScheduleDateSelected(selectedScheduleDate);
    }
  }
}
