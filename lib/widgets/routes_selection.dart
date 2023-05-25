import 'package:beba_app/model/driver_model.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoutesSelection extends StatefulWidget {
  final List<String>? options;
  final Function(String) onSelectOption;

  const RoutesSelection({
    super.key,
    required this.options,
    required this.onSelectOption,
  });

  @override
  State<RoutesSelection> createState() => _RoutesSelectionState();
}

class _RoutesSelectionState extends State<RoutesSelection> {
  String _selectedOption = 'NRB-ELD';

  bool get isDriver {
    final currentUserType = Provider.of<AuthProvider>(context).currentUserRole;
    return currentUserType == UserType.driver;
  }

  String get _driverRegisteredRoute {
    final registeredRoute = Provider.of<Driver>(context).route;
    return registeredRoute;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: isDriver ? _driverRegisteredRoute : _selectedOption,
      // Drivers can only bid for trip routes that are registered during application
      onChanged: isDriver
          ? null
          : (String? selectedOption) {
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
        'NRB-EMBU',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
