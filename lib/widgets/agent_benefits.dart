import 'package:flutter/material.dart';

class AgentBenefitsContainer extends StatelessWidget {
  const AgentBenefitsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.red[700],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Beba offers:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          BenefitCard(
            icon: Icons.timer,
            title: 'Flexible Schedule',
            description:
                'Set your own working hours and have a flexible schedule that suits your lifestyle.',
          ),
          BenefitCard(
            icon: Icons.local_shipping,
            title: 'Wide Range of Travellers',
            description:
                'Help onboard travellers from anywhere and everywhere.',
          ),
          BenefitCard(
            icon: Icons.attach_money,
            title: 'Earn Competitive Income',
            description:
                'Enjoy competitive earnings and bonuses based on your performance as an agent.',
          ),
          // Add more BenefitCard widgets for additional benefits if needed
        ],
      ),
    );
  }
}

class BenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const BenefitCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 32.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
