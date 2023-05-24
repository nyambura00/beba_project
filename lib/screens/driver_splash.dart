import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/contact_card.dart';
import 'package:beba_app/widgets/driver_hero_container.dart';
import 'package:beba_app/widgets/driver_step_measures.dart';
import 'package:flutter/material.dart';

class DriverSplashScreen extends StatelessWidget {
  const DriverSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppbarWidget(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const DriverHeroContainer(),
              const SizedBox(
                height: 30.0,
              ),
              const Text(
                'Follow the 2 steps below.',
                style: TextStyle(
                    fontFamily: 'SpaceMono',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              const DriverStepMeasures(),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/driverification',
                  );
                },
                child: const Text(
                  'Get verified',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const ContactCard()
            ],
          ),
        ));
  }
}
