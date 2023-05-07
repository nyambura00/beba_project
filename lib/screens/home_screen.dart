// import 'package:beba_app/screens/trips.dart';
// import 'package:beba_app/services/trips_db.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:beba_app/widgets/time_selection.dart';
// import 'package:beba_app/widgets/trip_card.dart';
import 'package:beba_app/widgets/routes_selection.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String routePlaceholder = 'NRB-ELD';
  String timePlaceholder = '8:00 AM';

  int _currentIndex = 0;

  // late TripService _tripService;

  // Future<void> _initializeTripService() async {

  //   final database = await openDatabase(inMemoryDatabasePath);
  //   _tripService = TripService(database);

  //   await _tripService.initialize();
  // }

  @override
  void initState() {
    super.initState();
    // _initializeTripService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              height: 1.0,
              color: Colors.grey[400],
            ),
            const SizedBox( height: 10.0,),
            const SizedBox(
              height: 35.0,
              child: Text(
                'Twende wapi?',
                style: TextStyle(fontFamily: 'SpaceMono', fontSize: 30.0, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: Colors.grey,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(4, 4)
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      const Text(
                        'Select Route: ',
                        style: TextStyle(fontFamily: 'SpaceMono', fontSize: 20.0, fontWeight: FontWeight.normal),
                      ),
                      RoutesSelection(
                        onSelectOption: (String placeholder) { routePlaceholder = placeholder; },
                        options: const [],
                      ),
                    ],
                  ),
                  const SizedBox( height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        'Pick Time:  ',
                        style: TextStyle(fontFamily: 'SpaceMono', fontSize: 20.0, fontWeight: FontWeight.normal,),
                      ),
                      TimeSelection(),
                    ],
                  ),
                  const SizedBox( height: 40.0,),
                  ElevatedButton(
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, 
                      foregroundColor: Colors.white,// background color
                      elevation: 5, // button's elevation
                      textStyle: const TextStyle(
                        color: Colors.white, // text color
                        fontSize: 20, // font size
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Search'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              height: 0.7,
              color: Colors.grey[300],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Available Routes',
                style: TextStyle( fontFamily: 'SpaceMono', fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Text('Today',
                style: TextStyle( fontFamily: 'SpaceMono', fontSize: 20.0, color: Colors.red),
              ),
            ),
            // SingleChildScrollView(
            //   child: FutureBuilder<void>(
            //     future: _initializeTripService(),
            //     builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         return TripsList();
            //       } else {
            //         return const CircularProgressIndicator();
            //       }
            //     },
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('See more...',
                style: TextStyle( fontFamily: 'SpaceMono', fontSize: 17.0, color: Colors.lightBlue),
              ),
            ),
          ],),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}