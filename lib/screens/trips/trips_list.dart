import 'package:beba_app/model/trip.dart';
import 'package:beba_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';

class TripList extends StatelessWidget {
  final List<Trip> trips;
  final bool isAgentView;

  const TripList({
    Key? key,
    required this.trips,
    this.isAgentView = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredTrips = isAgentView
        ? trips.where((trip) => trip.isApproved != true).toList()
        : trips.where((trip) => trip.isApproved == true).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredTrips.length,
      itemBuilder: (BuildContext context, int index) {
        return TripCard(trip: filteredTrips[index]);
      },
    );
  }
}
