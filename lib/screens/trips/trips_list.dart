import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripList extends StatelessWidget {
  final List<dynamic> trips;

  const TripList({
    Key? key,
    required this.trips,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userType = authProvider.currentUserRole;

    List<dynamic> filteredTrips = [];

    if (userType == UserType.agent || userType == UserType.superAdmin) {
      filteredTrips = trips;
    } else {
      filteredTrips = trips.where((trip) => trip.isApproved).toList();
    }

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
