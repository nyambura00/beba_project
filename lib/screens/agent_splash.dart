import 'package:beba_app/widgets/agent_benefits.dart';
import 'package:beba_app/widgets/agent_hero_container.dart';
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
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '- Supervise Beba operations(Manamba wa Beba)',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Text(
              '- Leverage on time. Get everything set.',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            AgentBenefitsContainer(),
            Divider(
              thickness: 4.0,
            ),
            AgentHeroContainer(),
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
