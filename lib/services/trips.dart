import 'package:beba_app/model/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference _tripsRef;

  TripsService() {
    _tripsRef = _db.collection('trips');
  }

  Future<List<Trip>> getTrips() async {
    final tripDocs =
        await _db.collection('trips').orderBy('startTime').get();
    return tripDocs.docs.map((doc) => Trip.fromMap(doc.data())).toList();
  }

  Future<void> addTrip(Trip trip) async {
    await _tripsRef.add(trip.toMap());
  }

  Future<void> updateTrip(Trip trip) async {
    await _tripsRef.doc(trip.id.toString()).update(trip.toMap());
  }

  Future<void> deleteTrip(int id) async {
    await _tripsRef.doc(id.toString()).delete();
  }
}
