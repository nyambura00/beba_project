import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Theme.of(context).colorScheme.background,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
          backgroundColor: Colors.black,
        ),
      ],
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/userhome');
            break;
          case 1:
            Navigator.pushNamed(context, '/notifications');
            break;
          case 2:
            Navigator.pushNamed(context, '/accountsettings');
            break;
        }
      },
      currentIndex: _currentIndex,
    );
  }
}
