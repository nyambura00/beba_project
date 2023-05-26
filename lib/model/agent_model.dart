import 'package:beba_app/model/user_model.dart';

class AgentModel extends UserModel {
  String idNumber;
  String locationAddress;
  String? idImage;

  AgentModel({
    required this.idNumber,
    required this.locationAddress,
    required idImage,
  }) : super(
            uid: '',
            fullName: '',
            bio: '',
            profilePic: '',
            phoneNumber: '',
            createdAt: '',
            role: 'AGENT');
}
