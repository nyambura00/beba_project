import 'package:flutter/material.dart';

class DriverStepMeasures extends StatefulWidget {
  const DriverStepMeasures({super.key});

  @override
  State<DriverStepMeasures> createState() => _DriverStepMeasuresState();
}

class _DriverStepMeasuresState extends State<DriverStepMeasures> {
  int _index = 0;
  
  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 1) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
          Navigator.pushNamed(context, '/login');
        } else {
          Navigator.pushNamed(context, '/driverification');
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Sign in to Account'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Sign in with Phone Number to access Driver Verification form.')),
        ),
        const Step(
          title: Text('Complete Driver Verification form'),
          content: Text('Fill Basic Details, Read and accept Terms and Conditions of working with Beba.'),
        ),
      ],
    );
  }
}