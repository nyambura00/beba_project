import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:beba_app/model/trip_model.dart';

class BookTripScreen extends StatefulWidget {
  final TripModel trip;

  const BookTripScreen({Key? key, required this.trip}) : super(key: key);

  @override
  State<BookTripScreen> createState() => _BookTripScreenState();
}

class _BookTripScreenState extends State<BookTripScreen> {
  bool _paymentConfirmed = false;

  void _confirmPayment() {
    setState(() {
      _paymentConfirmed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Book a Trip',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          TripCard(trip: widget.trip),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Payment',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Amount: ${widget.trip.unitFare}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Please confirm payment to book this trip:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _paymentConfirmed ? null : _confirmPayment,
                  child: Text(
                    _paymentConfirmed ? 'Payment Confirmed' : 'Confirm Payment',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
