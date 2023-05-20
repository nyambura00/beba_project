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
  bool isApproved;

  Trip({
    this.id,
    required this.source,
    required this.destination,
    required this.unitFare,
    required this.vehicleId,
    required this.startTime,
    required this.driverId,
    this.isApproved = false,
  }) {
    createdAt = DateTime.now().toString();
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
      'isApproved': isApproved,
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
      isApproved: map['isApproved'],
    );
  }

  @override
  String toString() {
    return 'Trip{id: $id, source: $source, destination: $destination, unitFare: $unitFare, vehicleId: $vehicleId, startTime: $startTime, driverId: $driverId, createdAt: $createdAt, isApproved: $isApproved}';
  }
}
