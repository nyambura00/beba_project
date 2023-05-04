import 'package:flutter/material.dart';

class RoutesSelection extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelectOption;

  const RoutesSelection({super.key, required this.options, required this.onSelectOption});

  @override
  State<RoutesSelection> createState() => _RoutesSelectionState();
}

class _RoutesSelectionState extends State<RoutesSelection> {
  String _selectedOption = 'NRB-ELD';

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
          'NRB-ELD',
          'NRB-GILGIL',
          'NRB-MSA',
          'NRB-MERU',
          'NRB-NYERI',
      ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
      }).toList(),
    );
  }
}