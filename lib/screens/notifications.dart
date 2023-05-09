import 'package:beba_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<String> _notifications = [    'Your ride has been cancelled',    'You have a new ride request',    'Your ride is approaching its destination',    'Your ride has been completed',  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        // foregroundColor: Colors.red[700],
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_notifications[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Do something when the user taps on a notification
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}