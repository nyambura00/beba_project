import 'dart:async';

import 'package:beba_app/model/trip.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/screens/account_settings.dart';
import 'package:beba_app/screens/auth/authgate.dart';
import 'package:beba_app/screens/auth/logout.dart';
import 'package:beba_app/screens/auth/signin.dart';
import 'package:beba_app/screens/contact_us.dart';
import 'package:beba_app/screens/home_screen.dart';
import 'package:beba_app/screens/user_profile.dart';
import 'package:beba_app/screens/welcome_screen.dart';
import 'package:beba_app/services/trips.dart';
import 'package:beba_app/widgets/beba_logo.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beba app',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const LandingPage(),
        initialRoute: '/',
        routes: {
          '/authgate':(context) => const AuthGate(),
          '/splash':(context) => const WelcomeScreen(),
          '/signin':(context) => const SigninScreen(),
          '/userhome': (context) => const HomeScreen(),
          '/accountsettings':(context) => const AccountSettingsScreen(),
          '/profile':(context) => const UserProfile(),
          '/contact':(context) => const ContactUsScreen(),
          '/logout':(context) => const LogoutScreen(),
        },
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  late TripsService _tripsService;

  @override
  void initState() {
    super.initState();
    _tripsService = TripsService();

    // Check if the trips collection is empty
    _tripsService.getTrips().then((trips) {
      if (trips.isEmpty) {
        // Create the Genesis Trip
        final genesisTrip = Trip(
          source: 'NRB',
          destination: 'ELD',
          unitFare: 1000,
          vehicleId: 12233455,
          startTime: DateTime.now().toString(),
          driverId: 'OXDriver1',
        );
        _tripsService.addTrip(genesisTrip);
      }
    });

    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(
        context,
        '/authgate',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            LogoText(),
            Text('a product of Scheduled Travels EA',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}