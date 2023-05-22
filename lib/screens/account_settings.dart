import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: Colors.red[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/userprofile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.switch_account),
              title: const Text('Become a Driver'),
              onTap: () {
                Navigator.pushNamed(context, '/driversplash');
              },
            ),
            const Divider(),
            const Text(
              'Payment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('M-PESA'),
              onTap: () {
                // Navigate to payment method screen
              },
            ),
            const Divider(),
            const Text(
              'About Beba',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.question_mark),
              title: const Text('FAQS'),
              onTap: () {
                // Navigate to change email screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Terms of Service'),
              onTap: () {
                // Navigate to change password screen
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
