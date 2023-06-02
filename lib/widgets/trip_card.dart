import 'package:beba_app/model/user_model.dart';
import 'package:beba_app/provider/trips_provider.dart';
import 'package:beba_app/screens/trips/unit_trip.dart';
import 'package:beba_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/model/trip_model.dart';
import 'package:provider/provider.dart';

class TripCard extends StatefulWidget {
  final TripModel trip;
  final bool isApproved;

  const TripCard({
    Key? key,
    required this.trip,
    this.isApproved = false,
  }) : super(key: key);

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  void handleApproval(String? tripId) async {
    try {
      final user = Provider.of<UserModel>(context, listen: false);
      await Provider.of<TripsProvider>(context, listen: false)
          .approveTrip(context, tripId, user);
      showSnackBar(context, 'Trip has been approved successfully');
    } catch (e) {
      print(e);
      showSnackBar(context, 'Error in Trip Approval');
      showSnackBar(context, 'Are you an agent? Contact Beba support');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Source: ${widget.trip.source}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Destination: ${widget.trip.destination}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Unit fare: ${widget.trip.unitFare}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Vehicle ID: ${widget.trip.vehicleId}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Start Time: ${widget.trip.startTime}',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        widget.trip.isApproved ? Colors.black : Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: widget.trip.isApproved
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnitTrip(tripCard: widget),
                            ),
                          );
                        }
                      : () {
                          try {
                            handleApproval(widget.trip.id);
                          } catch (e) {
                            // Handle trip approval error
                            print(e);
                            showSnackBar(context, 'Error in Trip Approval');
                          }
                        },
                  child: Text(
                      widget.trip.isApproved ? 'Book Trip' : 'Approve Trip'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
