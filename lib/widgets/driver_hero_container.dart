import 'package:flutter/material.dart';

class DriverHeroContainer extends StatefulWidget {
  const DriverHeroContainer({super.key});

  @override
  State<DriverHeroContainer> createState() => _DriverHeroContainerState();
}

class _DriverHeroContainerState extends State<DriverHeroContainer> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'driverSplash',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get started with Beba driving?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Want to leverage on time and get quick travellers?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}
