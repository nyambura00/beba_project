import 'package:flutter/material.dart';

class TimeSelection extends StatefulWidget {
  // final List<String> options;
  // final Function(String) onSelectOption;

  const TimeSelection({super.key});

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
  
  void onSelectOption(String selectedOption) {}
}

class _TimeSelectionState extends State<TimeSelection> {
  String _selectedOption = '8:00 AM';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedOption,
      onChanged: (String? selectedOption) {
        setState(() {
          _selectedOption = selectedOption!;
          widget.onSelectOption(_selectedOption);
        });
      },
      items: <String>[
          '8:00 AM',
          '10:00 AM',
          '12 Noon',
          '2:00 PM',
          '4:00 PM'
      ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
      }).toList(),
    );
  }
}