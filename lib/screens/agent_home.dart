// import 'package:beba_app/provider/trips_provider.dart';
import 'package:beba_app/screens/trips/trips_list.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
// import 'package:beba_app/model/trip_model.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class AgentDashboard extends StatefulWidget {
  const AgentDashboard({super.key});

  @override
  State<AgentDashboard> createState() => _AgentDashboardState();
}

class _AgentDashboardState extends State<AgentDashboard> {
  // late TripsProvider _tripsService;
  // List<TripModel> _trips = [];

  @override
  void initState() {
    super.initState();
    // _tripsService = TripsProvider();
    // _initTrips();
  }

  // void _initTrips() async {
  //   final trips = await _tripsService.fetchTrips(context);
  //   setState(() {
  //     _trips = trips;
  //   });
  // }

  var tripsCount = 4;

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
            Center(
              child: WidgetCircularAnimator(
                innerColor: Colors.black,
                outerColor: Colors.black,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(
                      child: Text(
                    'Total handled trips: $tripsCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'SpaceMono',
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            const Text(
              'Available Trips...',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const TripList(),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TripList()),
                  );
                },
                child: const Text(
                  'Click to see more...',
                  style: TextStyle(
                    fontFamily: 'SpaceMono',
                    fontSize: 17.0,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
