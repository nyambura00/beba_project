class Trip {
  final int id;
  final String uuid;
  final String source;
  final String destination;
  final int unitFare;
  final int vehicleId;
  final String startTime;
  final String driverId;
  final String createdAt;

  const Trip({
    required this.id,
    required this.uuid,
    required this.source, 
    required this.destination,
    required this.unitFare,
    required this.vehicleId,
    required this.startTime,
    required this.driverId,
    required this.createdAt,
  });

  // Convert a Trip into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'source': source,
      'destination': destination,
      'unitFare': unitFare,
      'vehicleId': vehicleId,
      'startTime': startTime,
      'driverId': driverId,
      'createdAt': createdAt,
    };
  }

  // Convert a Map into a Trip. The keys must correspond to the names of the
  // columns in the database.
  static Trip fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'],
      uuid: map['uuid'],
      source: map['source'],
      destination: map['destination'],
      unitFare: map['unitFare'],
      vehicleId: map['vehicleId'],
      startTime: map['startTime'],
      driverId: map['driverId'],
      createdAt: map['createdAt'],
    );
  }

  // Implement toString to make it easier to see information about
  // each trip when using the print statement.
  @override
  String toString() {
    return 'Trip{id: $id, uuid: $uuid, source: $source, destination: $destination, unitFare: $unitFare, vehicleId: $vehicleId, startTime: $startTime, driverId: $driverId, createdAt: $createdAt}';
  }
}