
// import 'package:beba/widgets/driver_call_action.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/contact_card.dart';
import 'package:beba_app/widgets/driver_hero_container.dart';
import 'package:beba_app/widgets/driver_step_measures.dart';
import 'package:flutter/material.dart';

class DriverSplashScreen extends StatelessWidget {
  const DriverSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox( height: 20.0, ),
            DriverHeroContainer(),
            SizedBox( height: 30.0, ),
            Text('Follow the 2 steps below.', 
              style: TextStyle(fontFamily: 'SpaceMono', fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            DriverStepMeasures(),
            SizedBox( height: 30.0, ),
            // DriverCallAction(),
            SizedBox( height: 40.0, ),
            ContactCard()
          ],
        ),
      )
    );
  }
}