import 'package:uuid/uuid.dart';

class Driver {
  String? id;
  String fullName;
  String idNumber;
  String licenseNumber;
  String plateNumber;
  String ntsaNumber;
  String imageAddress;
  String route;
  late String createdAt;

  Driver({
    this.id,
    required this.fullName,
    required this.idNumber,
    required this.licenseNumber,
    required this.plateNumber,
    required this.ntsaNumber,
    required this.imageAddress,
    required this.route,
  }) {
    createdAt = DateTime.now().toString();  // generate createdAt attribute
    id = const Uuid().v4(); 
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'] ?? '',
      fullName: map['fullName'] ?? '',
      idNumber: map['idNumber'] ?? '',
      licenseNumber: map['licenseNumber'] ?? '',
      plateNumber: map['plateNumber'] ?? '',
      ntsaNumber: map['ntsaNumber'] ?? '',
      imageAddress: map['imageAddress'] ?? '',
      route: map['route'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
    return 'Driver{ id: $id, fullName: $fullName, idNumber: $idNumber, licenseNumber: $licenseNumber, plateNumber: $plateNumber, ntsaNumber: $ntsaNumber, imageAddress: $imageAddress, route: $route, createdAt: $createdAt}';
  }
}

