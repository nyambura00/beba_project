import 'package:beba_app/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? _selectedOption;

  bool get isDriver {
    final currentUserType =
        Provider.of<AuthProvider>(context, listen: false).currentUserRole;
    return currentUserType == UserType.driver;
  }

  Future<String?> _driverRegisteredRoute() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userRole = authProvider.currentUserRole;

    if (userRole == UserType.driver) {
      final currentUserUid = authProvider.uid;
      final firestore = FirebaseFirestore.instance;

      try {
        final driverSnapshot =
            await firestore.collection('drivers').doc(currentUserUid).get();
        if (driverSnapshot.exists) {
          final driverData = driverSnapshot.data();
          final route = driverData!['route'] as String?;
          return route;
        }
      } catch (error) {
        // Handle any errors that occur during the Firestore operation
        print('Error retrieving driver data: $error');
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadInitialRoute();
  }

  Future<void> _loadInitialRoute() async {
    final driverRoute = await _driverRegisteredRoute();
    setState(() {
      _selectedOption =
          isDriver ? driverRoute : widget.options?.first ?? 'NRB-ELD';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _driverRegisteredRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final driverRoute = snapshot.data;
          return DropdownButton<String>(
            value: isDriver ? driverRoute : _selectedOption,
            // Drivers can only bid for trip routes that are registered during application
            onChanged: isDriver
                ? null
                : (String? selectedOption) {
                    setState(() {
                      _selectedOption = selectedOption!;
                      widget.onSelectOption(_selectedOption!);
                    });
                  },
            items:
                widget.options!.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
