import 'package:uuid/uuid.dart';

class DriverModel {
  String uid;
  String fullName;
  String phoneNumber;
  String licenseNumber;
  String ntsaNumber;
  String idNumber;
  String plateNumber;
  String role = 'DRIVER';
  String selectedRoute;
  String idImage;
  String ntsaImage;
  String driverImage;
  String vehicleImage;
  late DateTime createdAt = DateTime.now();

  DriverModel({
    required this.uid,
    required this.fullName,
    required this.phoneNumber,
    required this.licenseNumber,
    required this.ntsaNumber,
    required this.idNumber,
    required this.plateNumber,
    required this.role,
    required this.selectedRoute,
    required this.idImage,
    required this.ntsaImage,
    required this.driverImage,
    required this.vehicleImage,
  }) {
    uid = const Uuid().v4();
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      uid: map['uid']!,
      fullName: map['fullName']!,
      phoneNumber: map['phoneNumber']!,
      licenseNumber: map['licenseNumber']!,
      ntsaNumber: map['ntsaNumber']!,
      idNumber: map['idNumber']!,
      plateNumber: map['plateNumber']!,
      role: map['role']!,
      selectedRoute: map['selectedRoute']!,
      idImage: map['idImage']!,
      ntsaImage: map['ntsaImage']!,
      driverImage: map['driverImage']!,
      vehicleImage: map['vehicleImage']!,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "licenseNumber": licenseNumber,
      "ntsaNumber": ntsaNumber,
      "idNumber": idNumber,
      "plateNumber": plateNumber,
      "role": role,
      "selectedRoute": selectedRoute,
      "idImage": idImage,
      "ntsaImage": ntsaImage,
      "driverImage": driverImage,
      "vehicleImage": vehicleImage,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
