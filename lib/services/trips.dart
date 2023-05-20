import 'package:beba_app/model/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference _tripsRef;

  TripsService() {
    _tripsRef = _db.collection('trips');
  }

  Future<List<Trip>> getTrips() async {
    final tripDocs = await _tripsRef.where('isApproved', whereIn: [true, false])
        // .orderBy('startTime')
        .get();

    return tripDocs.docs
        .map((doc) => Trip.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<DocumentReference> addTrip(Trip trip) async {
    return _tripsRef.add(trip.toMap());
  }

  Future<void> updateTrip(Trip trip) async {
    await _tripsRef.doc(trip.id!).update(trip.toMap());
  }

  Future<void> deleteTrip(int id) async {
    await _tripsRef.doc(id.toString()).delete();
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2015, 8),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }
}
