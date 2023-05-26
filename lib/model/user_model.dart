class UserModel {
  String uid;
  String fullName;
  String bio;
  String profilePic;
  String phoneNumber;
  String createdAt;
  String role = 'DEFAULT_USER';

  UserModel({
    required this.uid,
    required this.fullName,
    required this.bio,
    required this.profilePic,
    required this.phoneNumber,
    required this.createdAt,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['name'] ?? '',
      bio: map['bio'] ?? '',
      profilePic: map['profilePic'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      role: map['role'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullName": fullName,
      "bio": bio,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "role": role,
    };
  }
}
