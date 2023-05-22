import 'package:beba_app/screens/trips/trips_list.dart';
import 'package:beba_app/services/trips.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/model/trip.dart';

class AgentDashboard extends StatefulWidget {
  const AgentDashboard({super.key});

  @override
  State<AgentDashboard> createState() => _AgentDashboardState();
}

class _AgentDashboardState extends State<AgentDashboard> {
  late TripsService _tripsService;
  List<Trip> _trips = [];

  @override
  void initState() {
    super.initState();
    _tripsService = TripsService();
    _initTrips();
  }

  void _initTrips() async {
    final trips = await _tripsService.getTrips();
    setState(() {
      _trips = trips;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10.0,
            ),
            // TODO: Add more relevant agent dashboard
            const Text(
              'Trips of the Day',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            const Text(
              '- Approve/Decline trips of the day',
              style: TextStyle(
                fontFamily: 'SpaceMono',
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TripList(trips: _trips),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
