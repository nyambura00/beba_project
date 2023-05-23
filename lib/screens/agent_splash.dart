import 'package:beba_app/screens/agent_registration.dart';
import 'package:beba_app/widgets/agent_benefits.dart';
import 'package:beba_app/widgets/app_bar.dart';
import 'package:beba_app/widgets/contact_card.dart';
import 'package:flutter/material.dart';

class AgentSplash extends StatefulWidget {
  const AgentSplash({super.key});

  @override
  State<AgentSplash> createState() => _AgentSplashState();
}

class _AgentSplashState extends State<AgentSplash> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Work with Beba',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            AgentBenefitsContainer(),
            AgentRegistration(),
            SizedBox(
              height: 20.0,
            ),
            ContactCard(),
          ],
        ),
      ),
    );
  }
}
