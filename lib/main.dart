import 'dart:async';

import 'package:beba_app/model/trip_model.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/provider/trips_provider.dart';
import 'package:beba_app/screens/account_settings.dart';
import 'package:beba_app/screens/agent_home.dart';
import 'package:beba_app/screens/agent_registration.dart';
import 'package:beba_app/screens/agent_splash.dart';
import 'package:beba_app/screens/auth/authgate.dart';
import 'package:beba_app/screens/auth/logout.dart';
import 'package:beba_app/screens/auth/signin.dart';
import 'package:beba_app/screens/auth/signin_agent.dart';
import 'package:beba_app/screens/auth/signin_driver.dart';
import 'package:beba_app/screens/auth/signin_superadmin.dart';
import 'package:beba_app/screens/contact_us.dart';
import 'package:beba_app/screens/driver_home.dart';
import 'package:beba_app/screens/driver_splash.dart';
import 'package:beba_app/screens/driver_verification.dart';
import 'package:beba_app/screens/home_screen.dart';
import 'package:beba_app/screens/notifications.dart';
import 'package:beba_app/screens/splash.dart';
import 'package:beba_app/screens/super_admin.dart';
import 'package:beba_app/screens/trips/agent_trips_confirm.dart';
import 'package:beba_app/screens/trips/bid_trip.dart';
import 'package:beba_app/screens/trips/book_trip.dart';
import 'package:beba_app/screens/trips/unit_trip.dart';
import 'package:beba_app/screens/user_profile.dart';
import 'package:beba_app/widgets/beba_logo.dart';
import 'package:beba_app/widgets/trip_card.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> initializeTrips(BuildContext context) async {
    final tripsService = TripsProvider();

    // Check if the trips collection is empty
    final trips = await tripsService.fetchTrips(context);
    if (trips.isEmpty) {
      // Create the Genesis Trip
      final genesisTrip = TripModel(
        source: 'NRB',
        destination: 'ELD',
        unitFare: '1000',
        vehicleId: '1',
        startTime: '8:00 AM',
        driverId: '0xDriver1',
      );
      tripsService.createTrip(genesisTrip);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TripsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Beba app',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: FutureBuilder<void>(
          future: initializeTrips(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ); // Show a loading indicator
            } else {
              return const LandingPage();
            }
          },
        ),
        initialRoute: '/',
        routes: {
          '/authgate': (context) => const AuthGate(),
          '/splash': (context) => const WelcomeScreen(),
          '/signin': (context) => const SigninScreen(),
          '/userhome': (context) => const HomeScreen(),
          '/accountsettings': (context) => const AccountSettingsScreen(),
          '/userprofile': (context) => const UserProfile(),
          '/booktrip': (context) => BookTripScreen(
                trip: ModalRoute.of(context)?.settings.arguments as TripModel,
              ),
          '/contact': (context) => const ContactUsScreen(),
          '/notifications': (context) => const NotificationsScreen(),
          '/logout': (context) => const LogoutScreen(),
          '/driversplash': (context) => const DriverSplashScreen(),
          '/driverification': (context) => const DriverVerificationForm(),
          '/driverhome': (context) => const DriverHomeScreen(),
          '/bidtrip': (context) => const BidTripScreen(),
          '/tripconfirmation': (context) => const TripConfirmation(),
          '/tripunit': (context) => UnitTrip(
                tripCard:
                    ModalRoute.of(context)?.settings.arguments as TripCard,
              ),
          '/agentsplash': (context) => const AgentSplash(),
          '/agentregistration': (context) => const AgentRegistration(),
          '/agentdashboard': (context) => const AgentDashboard(),
          '/signin/driver': (context) => const DriverSignin(),
          '/signin/agent': (context) => const AgentSignin(),
          '/signin/super_admin': (context) => const SuperAdminSignin(),
          '/superadminhome': (context) => const SuperAdminDashboard(),
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
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/authgate');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[700],
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoText(),
            Text(
              'a product of Scheduled Travels EA',
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
