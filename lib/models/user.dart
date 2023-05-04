import 'dart:ffi';

class User {

  int userId;
  int phoneNumber;
  String role;
  Bool verificationStatus;

  User({
    required this.userId, 
    required this.phoneNumber,
    required this.role,
    required this.verificationStatus,
  });
}