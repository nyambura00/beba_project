import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Beba',
      style: TextStyle(
        fontFamily: 'JotiOne',
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
        color: Colors.white,
      ),
    );
  }
}