import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePickerWidget extends StatefulWidget {
  final DateTime selectedStartDate;
  final DateTime selectedEndDate;
  final Function(DateTime) onStartDateSelected;
  final Function(DateTime) onEndDateSelected;

  const DateRangePickerWidget({
    Key? key,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.onStartDateSelected,
    required this.onEndDateSelected,
  }) : super(key: key);

  @override
  DateRangePickerWidgetState createState() => DateRangePickerWidgetState();
}

class DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;

  @override
  void initState() {
    super.initState();
    selectedStartDate = widget.selectedStartDate;
    selectedEndDate = widget.selectedEndDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: selectStartDate,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Job Starting Date',
              border: OutlineInputBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateFormat('yyyy-MM-dd').format(selectedStartDate),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: selectEndDate,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Job Ending Date',
              border: OutlineInputBorder(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  DateFormat('yyyy-MM-dd').format(selectedEndDate),
                ),
                const Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedStartDate = DateFormat('yyyy-MM-dd').parse(
          DateFormat('yyyy-MM-dd').format(picked),
        );
        selectedEndDate = selectedStartDate;
      });
      widget.onStartDateSelected(selectedStartDate);
      widget.onEndDateSelected(selectedEndDate);
    }
  }

  Future<void> selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: selectedStartDate,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedEndDate = DateFormat('yyyy-MM-dd').parse(
          DateFormat('yyyy-MM-dd').format(picked),
        );
      });
      widget.onEndDateSelected(selectedEndDate);
    }
  }
}
