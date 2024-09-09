import 'package:flutter/material.dart';

class AvailabilitySelector extends StatefulWidget {
  final Function(Map<String, List<String>>)? onAvailabilityChanged;

  AvailabilitySelector({this.onAvailabilityChanged});

  @override
  _AvailabilitySelectorState createState() => _AvailabilitySelectorState();
}

class _AvailabilitySelectorState extends State<AvailabilitySelector> {
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final List<String> _timeSlots = [
    '8:00 AM - 10:00 AM',
    '10:00 AM - 12:00 PM',
    '12:00 PM - 2:00 PM',
    '2:00 PM - 4:00 PM',
    '4:00 PM - 6:00 PM'
  ];

  Map<String, DayModel> _days = {};

  @override
  void initState() {
    super.initState();
    _days = Map.fromIterable(
      _daysOfWeek,
      key: (day) => day as String,
      value: (day) => DayModel(day: day as String),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _daysOfWeek.map((day) {
          final dayModel = _days[day]!;
          return ExpansionTile(
            title: Text(dayModel.day),
            children: _timeSlots.map((slot) {
              bool isSelected = dayModel.selectedSlots.contains(slot);
              return CheckboxListTile(
                title: Text(slot),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _days[day]!.selectedSlots.add(slot);
                    } else {
                      _days[day]!.selectedSlots.remove(slot);
                    }
                    if (widget.onAvailabilityChanged != null) {
                      widget.onAvailabilityChanged!({
                        for (var dm in _days.values)
                          dm.day: dm.selectedSlots,
                      });
                    }
                  });
                },
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  // Optional: Method to retrieve availability
  Map<String, List<String>> getAvailability() {
    return {
      for (var dm in _days.values) dm.day: dm.selectedSlots,
    };
  }
}

class DayModel {
  final String day;
  List<String> selectedSlots;

  DayModel({
    required this.day,
    List<String>? selectedSlots,
  }) : selectedSlots = selectedSlots ?? []; // Initialize with an empty list if null
}