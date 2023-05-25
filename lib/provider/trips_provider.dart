import 'package:beba_app/model/user_model.dart';
import 'package:beba_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:beba_app/model/trip.dart';

class TripsProvider extends ChangeNotifier {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _tripsCollection =
      FirebaseFirestore.instance.collection('trips');

  // Create a new trip
  Future<void> createTrip(Trip trip) async {
    try {
      await _tripsCollection.add(trip.toMap());
      notifyListeners();
    } catch (error) {
      // Handle the error appropriately
      print(error);
      // showSnackBar('Error creating trip: $error');
    }
  }

  // Get all trips
  Future<List<Trip>> fetchTrips(BuildContext context) async {
    try {
      final trips = await _tripsCollection
          .where('isApproved', whereIn: [true, false]).get();
      return trips.docs
          .map(
              (doc) => Trip.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print(e);
      showSnackBar(context, 'Error fetching Trips from db');
      return [];
    }
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
  Future<void> approveTrip(
      BuildContext context, String? tripId, UserModel user) async {
    if (user.role == 'SUPER_ADMIN' || user.role == 'AGENT') {
      try {
        await _tripsCollection.doc(tripId).update({'isApproved': true});
        notifyListeners();
      } catch (error) {
        // Handle the error appropriately
        showSnackBar(context, 'Error approving trip: $error');
      }
    } else {
      showSnackBar(context, 'Role error: You cannot approve trips.');
      showSnackBar(context, 'Please contact Beba support.');
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
  Stream<List<Trip>> searchTrips(String searchQuery, String selectedTime) {
    return _tripsCollection
        .where('destination', isGreaterThanOrEqualTo: searchQuery)
        .where('destination', isLessThan: '$searchQuery\uf8ff')
        .where('startTime', isEqualTo: selectedTime)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map(
              (doc) => Trip.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }
}
