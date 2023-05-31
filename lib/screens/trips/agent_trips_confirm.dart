import 'package:beba_app/provider/trips_provider.dart';
import 'package:beba_app/screens/trips/trips_list.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/model/trip_model.dart';

class TripConfirmation extends StatefulWidget {
  const TripConfirmation({super.key});

  @override
  State<TripConfirmation> createState() => _TripConfirmationState();
}

class _TripConfirmationState extends State<TripConfirmation> {
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
    return const Scaffold(
      appBar: AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Trips of the Day',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            Text(
              '- Approve/Decline trips of the day',
              style: TextStyle(
                fontFamily: 'SpaceMono',
                fontSize: 15.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TripList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
