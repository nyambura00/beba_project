import 'package:flutter/material.dart';

class AgentHeroContainer extends StatelessWidget {
  const AgentHeroContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'agentSplash',
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
              'Bebana with Beba',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Click the button below to complete the agent form',
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
                  '/agentregistration',
                );
              },
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 20.0, backgroundColor: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
