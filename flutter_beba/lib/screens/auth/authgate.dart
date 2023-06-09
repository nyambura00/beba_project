import 'package:beba_app/model/user_model.dart';
import 'package:beba_app/provider/auth_provider.dart';
import 'package:beba_app/screens/agent_home.dart';
import 'package:beba_app/screens/auth/signin.dart';
import 'package:beba_app/screens/driver_home.dart';
import 'package:beba_app/screens/home_screen.dart';
import 'package:beba_app/screens/super_admin.dart';
import 'package:beba_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SigninScreen();
        } else {
          final user = snapshot.data;
          return FutureBuilder<UserType>(
            future: getUserRole(context, user),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userType = snapshot.data;
                switch (userType) {
                  case UserType.superAdmin:
                    return const SuperAdminDashboard();
                  case UserType.agent:
                    return const AgentDashboard();
                  case UserType.driver:
                    return const DriverHomeScreen();
                  case UserType.defaultUser:
                  default:
                    return const HomeScreen();
                }
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        }
      },
    );
  }

  Future<UserType> getUserRole(BuildContext context, User? user) async {
    if (user != null) {
      final userModel = await getUserModelFromFirestore(user.uid);

      if (userModel != null) {
        final userRole = userModel.role;

        if (userRole.isNotEmpty) {
          return getUserRoleFromRoleString(userRole);
        } else {
          print('User role attribute is empty');
        }
      } else {
        print('User model not available');
      }
    } else {
      print('There is no user');
      showSnackBar(context, 'Please Sign In');
    }

    return UserType.defaultUser;
  }

  Future<UserModel?> getUserModelFromFirestore(String uid) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      final userData = snapshot.data();
      return UserModel.fromMap(userData!);
    } else {
      return null; // Return an empty UserModel if the document doesn't exist
    }
  }

  UserType getUserRoleFromRoleString(String role) {
    switch (role) {
      case 'SUPER_ADMIN':
        return UserType.superAdmin;
      case 'AGENT':
        return UserType.agent;
      case 'DRIVER':
        return UserType.driver;
      case 'DEFAULT_USER':
        return UserType.defaultUser;
      default:
        return UserType.defaultUser;
    }
  }
}
