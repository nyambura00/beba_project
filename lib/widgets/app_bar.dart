import 'package:beba_app/widgets/beba_logo.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({Key? key}) : super(key: key);

  final LogoText logoText = const LogoText();

  bool _isProtectedRoute(Route<dynamic> route) {
    // list of protected routes
    List<String> protectedRoutes = ['/userhome','/accountsettings', '/profile', '/contact', '/driverification','/driverhome', '/booktrip', '/createtrip'];
    // Check if the current route is in the list of protected routes
    return protectedRoutes.contains(route.settings.name);
  }
  
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context);

    return AppBar(
      automaticallyImplyLeading: false,
      title: logoText,
      backgroundColor: Colors.red[700],
      actions: _isProtectedRoute(currentRoute!) ? <Widget>[
        PopupMenuButton<String>(
          color: Colors.white,
          onSelected: (String choice) {
            // Perform action based on the selected choice
            switch (choice) {
              case 'Account Settings':
                // Navigate to the settings page
                Navigator.pushNamed(context, '/accountsettings');
                break;
              case 'Profile':
                // Navigate to the profile page
                Navigator.pushNamed(context, '/userprofile');
                break;
              case 'Contact Us':
                // Navigate to the profile page
                Navigator.pushNamed(context, '/contact');
                break;
              case 'Logout':
                // Navigate to the profile page
                Navigator.pushNamed(context, '/logout');
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            // Define the items in the popup menu
            return ['Account Settings', 'Profile', 'Contact Us', 'Logout'].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ]
      : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}