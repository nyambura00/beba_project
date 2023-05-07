import 'package:flutter/material.dart';
import 'package:beba_app/services/trips.dart';
import 'package:beba_app/widgets/trip_card.dart';
import 'package:beba_app/model/trip.dart';
import 'package:sqflite/sqflite.dart';

class TripsList extends StatefulWidget {

  const TripsList({super.key}); 
  @override
  State<TripsList> createState() => _TripsListState();
}

class _TripsListState extends State<TripsList> {
  late TripService tripService;
  List<Trip> _trips = []; 

  void _initTrips() async {
    final database = await openDatabase(inMemoryDatabasePath);
    tripService = TripService(database);

    await tripService.initialize();
    final trips = await tripService.trips();
    setState(() {
      _trips = trips;
    });
  }
  
  @override
  void initState() {
    super.initState();
    _initTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _trips.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _trips.length,
              itemBuilder: (BuildContext context, int index) {
                return TripCard(trip: _trips[index]);
              },
            ),
    );
  }
}