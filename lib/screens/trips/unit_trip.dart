import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

class UnitRoute extends StatefulWidget {
  const UnitRoute({super.key});

  @override
  State<UnitRoute> createState() => _UnitRouteState();
}

class _UnitRouteState extends State<UnitRoute> {
  List<Map<String, dynamic>> _routes = [];

  Future<void> _fetchRoutes() async {
    String loadJsonData = await rootBundle.loadString('assets/routes.json');
    final response = json.decode(loadJsonData);

    if (response!) {
      final jsonBody = json.decode(response.body);
      _routes = List<Map<String, dynamic>>.from(jsonBody['routes']);
    } else {
      throw Exception('Failed to fetch routes');
    }
  }

  final int _selectedRouteIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchRoutes();
  }

  @override
  Widget build(BuildContext context) {
    if (_routes.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final route = _routes[_selectedRouteIndex];
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          // Handle tap on card
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(route['name'], style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 4),
                  Text(route['date']),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time),
                  const SizedBox(width: 4),
                  Text(route['time']),
                ],
              ),
              const SizedBox(height: 8),
              Text('Price: ${route['unit_fare']}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => BookTrip()),
                  // );
                },
                child: const Text('Book Trip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}