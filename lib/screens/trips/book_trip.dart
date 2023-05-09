import 'package:beba_app/model/trip.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:beba_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BookTripScreen extends StatefulWidget {
  final Trip? trip;

  const BookTripScreen({Key? key, required this.trip}) : super(key: key);

  @override
  _BookTripScreenState createState() => _BookTripScreenState();
}

class _BookTripScreenState extends State<BookTripScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Book Trip',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'SpaceMono',
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Trip Details',
                          style: TextStyle(
                            fontFamily: 'SpaceMono',
                            color: Colors.grey,
                            fontSize: 17.0,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Source: ${widget.trip!.source}',
                          style: const TextStyle(
                            fontFamily: 'SpaceMono',
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Destination: ${widget.trip!.destination}',
                          style: const TextStyle(
                            fontFamily: 'SpaceMono',
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Unit Fare: KES ${widget.trip!.unitFare}',
                          style: const TextStyle(
                            fontFamily: 'SpaceMono',
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Start Time: ${widget.trip!.startTime}',
                          style: const TextStyle(
                            fontFamily: 'SpaceMono',
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: CustomButton(
                  text: "Confirm",
                  onPressed: () {
                    // MPESA API endpoint
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
