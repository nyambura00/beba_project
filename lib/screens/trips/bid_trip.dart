import 'package:beba_app/model/driver_model.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/utils/utils.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:beba_app/widgets/routes_selection.dart';
import 'package:beba_app/widgets/time_selection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BidTripScreen extends StatefulWidget {
  const BidTripScreen({super.key});

  @override
  State<BidTripScreen> createState() => _BidTripScreenState();
}

class _BidTripScreenState extends State<BidTripScreen> {
  final _formKey = GlobalKey<FormState>();

  //a variable to hold the driver's route value
  late String driverRoute = '';

  //a variable to hold user route placeholder
  late String userRoute = '';

  bool get isDriver {
    final currentUserType =
        Provider.of<AuthProvider>(context, listen: false).currentUserRole;
    return currentUserType == UserType.driver;
  }

  @override
  void initState() {
    super.initState();
    // Retrieve the driver's route value from the database
    getDriverRoute().then((value) {
      setState(() {
        driverRoute = value;
      });
    });
  }

  Future<String> getDriverRoute() async {
    try {
      final userSelectedRoute =
          Provider.of<Driver>(context, listen: false).route;
      driverRoute = userSelectedRoute;
      return driverRoute;
    } catch (e) {
      showSnackBar(context, 'Only drivers can bid on trips');
      Navigator.pushNamedAndRemoveUntil(
          context, '/driverification', (route) => false);
      rethrow;
    }
  }

  void submitBid() {
    if (isDriver) {
      showSnackBar(
        context,
        //TODO: Render bids in the form of trip cards to agents for approval
        'Bid submitted successfully. Please await approval.',
      );
    } else {
      showSnackBar(
        context,
        'Only registered drivers can bid on trips.',
      );
    }
  }

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
                  const Text(
                    'Bid Trip',
                    style: TextStyle(
                      fontFamily: 'SpaceMono',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '- Check out for a slot from Beba :)',
                    style: TextStyle(
                      fontFamily: 'SpaceMono',
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Registered Route: ',
                        style:
                            TextStyle(fontFamily: 'SpaceMono', fontSize: 20.0),
                      ),
                      RoutesSelection(
                        options: isDriver ? null : const [],
                        onSelectOption: (selectedOption) {
                          try {
                            isDriver
                                ? setState(
                                    () => driverRoute = selectedOption,
                                  )
                                : null;
                          } catch (e) {
                            print(e);
                            showSnackBar(context,
                                'Drivers cannot change their registered route');
                          }
                        },
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      GestureDetector(
                        onTap: () =>
                            {Navigator.pushNamed(context, '/driverification')},
                        child: const Text(
                          'change route?',
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'SpaceMono',
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Pick time: ',
                        style:
                            TextStyle(fontFamily: 'SpaceMono', fontSize: 20.0),
                      ),
                      TimeSelection(),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: submitBid,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 15.0),
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
