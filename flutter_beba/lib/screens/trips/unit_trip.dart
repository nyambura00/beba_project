import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:beba_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/services/api_service.dart';

class UnitTrip extends StatelessWidget {
  final TripCard tripCard;
  final apiService = ApiService();

  const UnitTrip({Key? key, required this.tripCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Trip Details',
                style: TextStyle(backgroundColor: Colors.grey, fontSize: 25.0),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Source: ${tripCard.trip.source}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Destination: ${tripCard.trip.destination}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Unit fare: ${tripCard.trip.unitFare}',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Vehicle ID: ${tripCard.trip.vehicleId}',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Start Time: ${tripCard.trip.startTime}',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Perform STK push for trip confirmation
                  // Replace the following code with your implementation
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Trip'),
                      content: const Text(
                          'Are you sure you want to confirm this trip?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            //Perform STK push here
                            await apiService.initiateStkPush();

                            // Close the dialog
                            Navigator.pop(context); 
                            
                            // Show a success message or navigate to a success screen
                            showSnackBar(context, 'Trip has been booked successfuly');
                          },
                          child: const Text('Confirm'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Confirm Trip'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
