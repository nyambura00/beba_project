import 'package:beba_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/model/trip.dart';
import 'package:provider/provider.dart';

class TripCard extends StatefulWidget {
  final Trip trip;
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
  @override
  Widget build(BuildContext context) {
    // final UserType userType = Provider.of<AuthProvider>(context).getUserType();

    // bool canApproveTrip =
    //     userType == UserType.agent || userType == UserType.superAdmin;

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
                        widget.isApproved ? Colors.black : Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: widget.isApproved
                      ? () {
                          Navigator.pushNamed(context, '/tripunit',
                              arguments: widget.trip);
                        }
                      : () {
                          // Handle trip approval logic here
                          // canApproveTrip ? :
                        },
                  child: Text(widget.isApproved ? 'Book Trip' : 'Approve Trip'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
