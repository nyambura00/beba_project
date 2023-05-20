import 'package:flutter/material.dart';
import 'package:beba_app/model/trip.dart';
import 'package:beba_app/widgets/trip_card.dart';

class TripConfirmation extends StatefulWidget {
  const TripConfirmation({super.key});

  @override
  State<TripConfirmation> createState() => _TripConfirmationState();
}

class _TripConfirmationState extends State<TripConfirmation> {
  List<Trip> trips = []; // List to hold the trips

  @override
  void initState() {
    super.initState();
    // TODO: Replace this with your own method to fetch trips with isApproved as false
    fetchTrips().then((trips) {
      setState(() {
        this.trips = trips;
      });
    });
  }

  // TODO: Replace this with your own method to fetch trips with isApproved as false
  Future<List<Trip>> fetchTrips() async {
    // Example implementation using dummy data
    return [
      Trip(
        source: 'Source 1',
        destination: 'Destination 1',
        unitFare: 10,
        vehicleId: 1,
        startTime: '9:00 AM',
        driverId: 'Driver 1',
        isApproved: false,
      ),
      Trip(
        source: 'Source 2',
        destination: 'Destination 2',
        unitFare: 20,
        vehicleId: 2,
        startTime: '10:00 AM',
        driverId: 'Driver 2',
        isApproved: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Text('Trips of the Day'),
          const SizedBox(
            height: 20.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: trips.map((trip) {
              return TripCard(
                trip: trip,
                onToggleApproval: () {
                  // Handle approval toggle logic here
                  // You can update the trip's isApproved property in the list or perform any other necessary actions
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
