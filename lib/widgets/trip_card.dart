import 'package:flutter/material.dart';
import 'package:beba_app/model/trip.dart';

class TripCard extends StatefulWidget {
  final Trip trip;
  final Function(bool)
      onToggleApproval; // New attribute to handle approval toggle

  const TripCard(
      {super.key, required this.trip, required this.onToggleApproval});

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  bool isApproved = false; // Track the approval state

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
                    backgroundColor: isApproved ? Colors.green : Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isApproved = !isApproved; // Toggle the approval state
                    });
                    widget.onToggleApproval(
                        isApproved); // Invoke the provided callback
                  },
                  child: Text(isApproved
                      ? 'Approved'
                      : 'Pending'), // Show appropriate text based on approval state
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
