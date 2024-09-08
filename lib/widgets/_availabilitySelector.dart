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

  Map<String, List<String>> _availability = {};

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _availability[_daysOfWeek[index]] =
          _availability[_daysOfWeek[index]]  ?? [] ;
        });
      },
      children: _daysOfWeek.map<ExpansionPanel>((String day) {
        bool isExpanded = _availability.containsKey(day);
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(day),
            );
          },
          body: Column(
            children: _timeSlots.map((slot) {
              bool isSelected = _availability[day]?.contains(slot) ?? false;
              return CheckboxListTile(
                title: Text(slot),
                value: isSelected,
                onChanged: isExpanded
                    ? (bool? value) {
                  setState(() {
                    if (value == true) {
                      _availability.putIfAbsent(day, () => []).add(slot);
                    } else {
                      _availability[day]?.remove(slot);
                      if (_availability[day]?.isEmpty ?? false) {
                        _availability.remove(day);
                      }
                    }
                    if (widget.onAvailabilityChanged != null) {
                      widget.onAvailabilityChanged!(_availability);
                    }
                  });
                }
                    : null,
              );
            }).toList(),
          ),
          isExpanded: isExpanded,
        );
      }).toList(),
    );
  }

  // Optional: Method to retrieve availability
  Map<String, List<String>> getAvailability() {
    return _availability;
  }
}
