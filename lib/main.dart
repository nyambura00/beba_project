import 'dart:async';

import 'package:beba_app/repository/authrepo.dart';
import 'package:beba_app/screens/auth/authgate.dart';
import 'package:beba_app/screens/auth/signin.dart';
import 'package:beba_app/screens/userhome.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform )
    .then((value) => Get.put(AuthenticationRepository()));
    
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beba app',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LandingPage(),
      initialRoute: '/',
      routes: {
        '/authgate':(context) => const AuthGate(),
        '/signin':(context) => const SigninScreen(),
        '/userhome': (context) => const HomeScreen(),
      },
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
      Navigator.pushNamed(
        context,
        '/authgate',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Beba',
              style: TextStyle(
                fontFamily: 'JotiOne',
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: Colors.white,
              )
            ),
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