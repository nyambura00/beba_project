import 'package:beba_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:beba_app/model/trip.dart';

class TripsProvider extends ChangeNotifier {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _tripsCollection =
      FirebaseFirestore.instance.collection('trips');

  // Create a new trip
  Future<void> createTrip(BuildContext context, Trip trip) async {
    try {
      await _tripsCollection.add(trip.toMap());
      notifyListeners();
    } catch (error) {
      // Handle the error appropriately
      showSnackBar(context, 'Error creating trip: $error');
    }
  }

  // Get all trips
  Stream<List<Trip>> get trips {
    return _tripsCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map(
              (doc) => Trip.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  // Update an existing trip
  Future<void> updateTrip(BuildContext context, Trip trip) async {
    try {
      await _tripsCollection.doc(trip.id).update(trip.toMap());
      notifyListeners();
    } catch (error) {
      // Handle the error appropriately
      showSnackBar(context, 'Error updating trip: $error');
    }
  }

  // Delete a trip
  Future<void> deleteTrip(BuildContext context, String tripId) async {
    try {
      await _tripsCollection.doc(tripId).delete();
      notifyListeners();
    } catch (error) {
      // Handle the error appropriately
      showSnackBar(context, 'Error deleting trip: $error');
    }
  }

  // Approve a trip
  Future<void> approveTrip(BuildContext context, String? tripId) async {
    try {
      await _tripsCollection.doc(tripId).update({'isApproved': true});
      notifyListeners();
    } catch (error) {
      // Handle the error appropriately
      showSnackBar(context, 'Error approving trip: $error');
    }
  }

  // Disapprove a trip
  Future<void> disapproveTrip(BuildContext context, String tripId) async {
    try {
      await _tripsCollection.doc(tripId).update({'isApproved': false});
      notifyListeners();
    } catch (error) {
      // Handle the error appropriately
      showSnackBar(context, 'Error disapproving trip: $error');
    }
  }

  // Search trips based on criteria
  Stream<List<Trip>> searchTrips(String searchQuery) {
    return _tripsCollection
        .where('source', isGreaterThanOrEqualTo: searchQuery)
        .where('source', isLessThan: '${searchQuery}z')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map(
              (doc) => Trip.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }
}
