import 'package:beba_app/model/user_model.dart';
import 'package:uuid/uuid.dart';

class Driver extends UserModel {
  String? driverId;
  String idNumber;
  String licenseNumber;
  String plateNumber;
  String ntsaNumber;
  String imageAddress;
  String route;
  late String driverCreatedAt;

  Driver({
    required this.driverId,
    required this.idNumber,
    required this.licenseNumber,
    required this.plateNumber,
    required this.ntsaNumber,
    required this.imageAddress,
    required this.route,
  }) : super(
            uid: '',
            fullName: '',
            bio: '',
            profilePic: '',
            phoneNumber: '',
            createdAt: '',
            role: 'DRIVER') {
    driverCreatedAt = DateTime.now().toString(); // generate createdAt attribute
    driverId = const Uuid().v4();
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      driverId: map['id'] ?? '',
      idNumber: map['idNumber'] ?? '',
      licenseNumber: map['licenseNumber'] ?? '',
      plateNumber: map['plateNumber'] ?? '',
      ntsaNumber: map['ntsaNumber'] ?? '',
      imageAddress: map['imageAddress'] ?? '',
      route: map['route'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'fullName': fullName,
      'idNumber': idNumber,
      'licenseNumber': licenseNumber,
      'plateNumber': plateNumber,
      'ntsaNumber': ntsaNumber,
      'imageAddress': imageAddress,
      'route': route,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'Driver{ driverId: $driverId, fullName: $fullName, idNumber: $idNumber, licenseNumber: $licenseNumber, plateNumber: $plateNumber, ntsaNumber: $ntsaNumber, imageAddress: $imageAddress, route: $route, createdAt: $createdAt}';
  }
}
