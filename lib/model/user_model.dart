class UserModel {
  String uid;
  String name;
  String email;
  String bio;
  String profilePic;
  String phoneNumber;
  String createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.bio,
    required this.profilePic,
    required this.phoneNumber,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      profilePic: map['profilePic'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "bio": bio,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
    };
  }
}