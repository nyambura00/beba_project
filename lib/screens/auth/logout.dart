import 'package:beba_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Log out?'),
        ElevatedButton(
          onPressed: () {
            AuthProvider().userSignOut(context);
          }, 
          child: const Text('Sign out'),
        ),
      ],
    );
  }
}