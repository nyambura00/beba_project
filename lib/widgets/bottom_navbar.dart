import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
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
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: const <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications,),
          label: '',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: '',
          backgroundColor: Colors.black,
        ),
      ],
    );
  }
}