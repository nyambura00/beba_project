import 'package:beba_app/model/trip.dart';
import 'package:beba_app/provider/trips_provider.dart';
import 'package:beba_app/screens/trips/trips_list.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:beba_app/widgets/verification_icon.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  late int tripsCount = 7; // TODO: Implement trips_count function

  late TripsProvider _tripsService;
  List<TripModel> _trips = [];

  @override
  void initState() {
    super.initState();
    _tripsService = TripsProvider();
    _initTrips();
  }

  void _initTrips() async {
    final trips = await _tripsService.fetchTrips(context);
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const VerificationIcon(size: 34.0, color: Colors.green),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text(
                    'Verification Status',
                    style: TextStyle(fontFamily: 'SpaceMono', fontSize: 15.0),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => {Navigator.pushNamed(context, '/bidtrip')},
                    style: ElevatedButton.styleFrom(
                      // alignment: Alignment.topRight,
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white, // background color
                      elevation: 5, // button's elevation
                      textStyle: const TextStyle(
                        color: Colors.white, // text color
                        fontSize: 20, // font size
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadowColor: Colors.grey,
                      // // Add margin to the right of the button
                      // padding: EdgeInsets.only(right: 16.0),
                    ),
                    child: const Text('Bid New Trip'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
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
                    'Total trips: $tripsCount',
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
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Available Trips',
              style: TextStyle(
                fontFamily: 'SpaceMono',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TripList(trips: _trips),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
