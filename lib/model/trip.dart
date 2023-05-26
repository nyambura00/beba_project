import 'package:uuid/uuid.dart';

class TripModel {
  String? id;
  final String source;
  final String destination;
  final String unitFare;
  final String vehicleId;
  final String startTime;
  final String driverId;
  late DateTime createdAt;
  bool isApproved;

  TripModel({
    this.id,
    required this.source,
    required this.destination,
    required this.unitFare,
    required this.vehicleId,
    required this.startTime,
    required this.driverId,
    this.isApproved = false,
  }) {
    createdAt = DateTime.now();
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

  static TripModel fromMap(Map<String, dynamic> map, String id) {
    return TripModel(
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

  String get route {
    return '$source-$destination';
  }
}
