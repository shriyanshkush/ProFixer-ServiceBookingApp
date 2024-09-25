import 'package:flutter/material.dart';

class AvailabilitySelector extends StatefulWidget {
  final Function(Map<String, List<Map<String, bool>>>)? onAvailabilityChanged;

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

  Map<String, List<Map<String, bool>>> _availability = {};

  @override
  void initState() {
    super.initState();

    // Initialize each day with time slots set to false (unavailable)
    _availability = Map.fromIterable(
      _daysOfWeek,
      key: (day) => day,
      value: (day) => _timeSlots.map((slot) => {slot: false}).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _daysOfWeek.map((day) {
          return ExpansionTile(
            title: Text(day),
            children: _availability[day]!.map((slotMap) {
              String timeSlot = slotMap.keys.first;
              bool isSelected = slotMap[timeSlot]!;
              return CheckboxListTile(
                title: Text(timeSlot),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    _availability[day]!.forEach((slot) {
                      if (slot.containsKey(timeSlot)) {
                        slot[timeSlot] = value!;
                      }
                    });

                    // Notify parent widget about the change
                    if (widget.onAvailabilityChanged != null) {
                      widget.onAvailabilityChanged!(_availability);
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
  Map<String, List<Map<String, bool>>> getAvailability() {
    return _availability;
  }
}
