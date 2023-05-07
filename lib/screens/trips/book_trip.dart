import 'package:beba_app/model/trip.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class BookTrip extends StatefulWidget {
  final Trip trip;
  const BookTrip({super.key, required this.trip});

  @override
  State<BookTrip> createState() => _BookTripState();
}

class _BookTripState extends State<BookTrip> {
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
                      children: const [
                        Text('Book Trip',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'SpaceMono',
                          ),
                        ),
                        Text('Enjoy extended trips conveniently',
                          style: TextStyle(
                            fontFamily: 'SpaceMono',
                            color: Colors.grey,
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox( height: 15.0,),
                    const Card(
                      // child: TripCard(trip: widget,),
                    ),
                  ],
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