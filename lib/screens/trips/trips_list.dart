import 'package:beba_app/model/trip.dart';
import 'package:beba_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;

  const TripList({
    Key? key,
    required this.trips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: trips.length,
      itemBuilder: (BuildContext context, int index) {
        return TripCard(trip: trips[index]);
      },
    );
  }
}
