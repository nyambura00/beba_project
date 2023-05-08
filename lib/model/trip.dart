import 'package:uuid/uuid.dart';

class Trip {
  String? id;
  final String source;
  final String destination;
  final int unitFare;
  final int vehicleId;
  final String startTime;
  final String driverId;
  late String createdAt;

  Trip({
    this.id,
    required this.source, 
    required this.destination,
    required this.unitFare,
    required this.vehicleId,
    required this.startTime,
    required this.driverId,
  }) {
    createdAt = DateTime.now().toString();  // generate createdAt attribute
    id = const Uuid().v4();  
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'source': source,
      'destination': destination,
      'unitFare': unitFare,
      'vehicleId': vehicleId,
      'startTime': startTime,
      'driverId': driverId,
      'createdAt': createdAt,
    };
  }

  static Trip fromMap(Map<String, dynamic> map, String id) {
    return Trip(
      id: map['id'],
      source: map['source'],
      destination: map['destination'],
      unitFare: map['unitFare'],
      vehicleId: map['vehicleId'],
      startTime: map['startTime'],
      driverId: map['driverId'],
    );
  }

  @override
  String toString() {
    return 'Trip{id: $id, source: $source, destination: $destination, unitFare: $unitFare, vehicleId: $vehicleId, startTime: $startTime, driverId: $driverId, createdAt: $createdAt}';
  }
}