class UserModel {
  String uid;
  String name;
  String bio;
  String profilePic;
  String phoneNumber;
  String createdAt;
  String role;

  UserModel({
    required this.uid,
    required this.name,
    required this.bio,
    required this.profilePic,
    required this.phoneNumber,
    required this.createdAt,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
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
      "name": name,
      "bio": bio,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "role": role,
    };
  }
}
