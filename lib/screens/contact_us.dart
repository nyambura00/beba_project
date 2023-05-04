import 'package:beba_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need help or have a question?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Contact us using one of the methods below:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('support@transitcompany.com'),
              onTap: () async {
                const url = 'mailto:support@transitcompany.com';
                if (await canLaunchUrl(url as Uri)) {
                  await launchUrl(url as Uri);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone'),
              subtitle: const Text('+1 (123) 456-7890'),
              onTap: () async {
                const url = 'tel:+11234567890';
                if (await canLaunchUrl(url as Uri)) {
                  await launchUrl(url as Uri);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Live Chat'),
              subtitle: const Text('Chat with us now'),
              onTap: () {
                // Navigate to live chat screen
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Visit Us'),
              subtitle: const Text('123 Main Street, City, State, Zip Code'),
              onTap: () async {
                const url =
                    'https://www.google.com/maps?q=123+Main+Street+City+State+Zip+Code';
                if (await canLaunchUrl(url as Uri)) {
                  await launchUrl(url as Uri);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}