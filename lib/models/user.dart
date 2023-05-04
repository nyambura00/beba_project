class User {

  String userId;
  String phoneNumber;
  String role;
  bool verificationStatus;

  User({
    required this.userId, 
    required this.phoneNumber,
    required this.role,
    required this.verificationStatus,
  });
}