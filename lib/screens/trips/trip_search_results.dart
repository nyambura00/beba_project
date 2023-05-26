import 'package:beba_app/model/trip.dart';
import 'package:beba_app/provider/trips_provider.dart';
import 'package:beba_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripSearchResults extends StatelessWidget {
  final String searchQuery;
  final String selectedTime;

  const TripSearchResults({
    Key? key,
    required this.searchQuery,
    required this.selectedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tripsProvider = Provider.of<TripsProvider>(context);
    return StreamBuilder<List<TripModel>>(
      stream: tripsProvider.searchTrips(searchQuery, selectedTime),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final trips = snapshot.data!;
          if (trips.isEmpty) {
            return const Center(
              child: Text('No trips found.'),
            );
          }
          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return TripCard(trip: trip);
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading trips: ${snapshot.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
