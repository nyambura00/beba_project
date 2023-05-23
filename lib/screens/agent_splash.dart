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
            AgentHeroContainer(),
            // Agent form submission
            ContactCard(),
          ],
        ),
      ),
    );
  }
}
