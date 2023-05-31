import 'package:beba_app/model/trip_model.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/provider/trips_provider.dart';
import 'package:beba_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripList extends StatelessWidget {
  const TripList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userType = authProvider.currentUserRole;

    return FutureBuilder<List<TripModel>>(
      future: Provider.of<TripsProvider>(context).fetchTrips(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while fetching trips
        } else if (snapshot.hasError) {
          // Show a snackbar with the error message
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final errorMessage = 'Error fetching trips: ${snapshot.error}';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
              ),
            );
          });
          print(userType);
          return Container(); // Return an empty container when there's an error
        } else {
          List<dynamic> trips = snapshot.data ?? [];

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
      },
    );
  }
}
