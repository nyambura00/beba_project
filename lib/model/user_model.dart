import 'package:uuid/uuid.dart';

class UserModel {
  String uid;
  String fullName;
  String bio;
  String profilePic;
  String phoneNumber;
  String role = 'DEFAULT_USER';
  late DateTime createdAt = DateTime.now();

  UserModel({
    required this.uid,
    required this.fullName,
    required this.bio,
    required this.profilePic,
    required this.phoneNumber,
    required this.role,
  }) {
    uid = const Uuid().v4();
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid']!,
      fullName: map['fullName']!,
      bio: map['bio']!,
      profilePic: map['profilePic']!,
      phoneNumber: map['phoneNumber']!,
      role: map['role']!,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullName": fullName,
      "bio": bio,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt.toIso8601String(),
      "role": role,
    };
  }
}
