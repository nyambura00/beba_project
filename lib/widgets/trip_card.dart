import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/provider/trips_provider.dart';
import 'package:beba_app/utils/utils.dart';
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
  void approveTrips(BuildContext context, Trip? trip) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userType = authProvider.getUserRole();

    final tripsProvider = Provider.of<TripsProvider>(context, listen: false);

    // Check if the user has the authority to approve trips
    bool canApproveTrip =
        userType == UserType.agent || userType == UserType.superAdmin;

    if (canApproveTrip) {
      trip!.isApproved = true;
      tripsProvider.approveTrip(context, trip.id);

      showSnackBar(context, 'Trip has been approved successfully');
    } else {
      // User does not have the authority to approve trips
      showSnackBar(context, 'Role error: You cannot approve trips.');
      showSnackBar(context, 'Please contact Beba support.');
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
                        widget.isApproved ? Colors.black : Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: widget.isApproved
                      ? () {
                          Navigator.pushNamed(context, '/tripunit',
                              arguments: widget.trip);
                        }
                      : () {
                          try {
                            // Handle trip approval logic here
                            approveTrips(context, widget.trip);
                            showSnackBar(
                                context, 'Trip has been successfully approved');
                          } catch (e) {
                            // Handle trip approval error
                            print(e);
                            showSnackBar(context, 'Error in Trip Approval');
                          }
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
