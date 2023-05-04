import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:beba_app/widgets/routes_selection.dart';
import 'package:beba_app/widgets/time_selection.dart';
import 'package:flutter/material.dart';

class BidTripScreen extends StatefulWidget {
  const BidTripScreen({super.key});

  @override
  State<BidTripScreen> createState() => _BidTripScreenState();
}

class _BidTripScreenState extends State<BidTripScreen> {
  final _formKey = GlobalKey<FormState>();

  var routePlaceholder = 'NRB-ELD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Bid on a New Trip',
                    style: TextStyle(
                      fontFamily: 'SpaceMono',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox( height: 20.0,),
                  Row(
                    children: [
                      const Text('Route Name: ',
                        style: TextStyle( fontFamily: 'SpaceMono'),
                      ),
                      RoutesSelection(options: const [], onSelectOption: (String placeholder) { routePlaceholder = placeholder; } ),
                      const SizedBox( width: 15.0,),
                      GestureDetector(
                        onTap: () => { Navigator.pushNamed(context, '/driverification') },
                        child: const Text('change route?', 
                          style: TextStyle(color: Colors.red, fontFamily: 'SpaceMono', decoration: TextDecoration.underline, decorationColor: Colors.red),
                        ),
                      )
                    ],
                  ),
                  const SizedBox( height: 20.0,),
                  Row(
                    children: const [
                      Text('Pick time: ',
                        style: TextStyle( fontFamily: 'SpaceMono'),
                      ),
                      TimeSelection(),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/trips'),
                    }, 
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('search',
                      style: TextStyle( fontSize: 15.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}