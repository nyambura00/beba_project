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
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Become a Beba Agent Today:)',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Ready to supervise Beba services?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ]),
      ),
    );
  }
}
