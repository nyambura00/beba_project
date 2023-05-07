import 'dart:async';

import 'package:beba_app/model/trip.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class TripService {
  late Database database;

  TripService(this.database);

  Future<Database> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'beba_database.db');
    
    return database = await openDatabase(
      path,
      onCreate: (Database db, version) async {
        // final uuid = Uuid().v4();
        await db.execute('''
          CREATE TABLE trips(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uuid TEXT,
            source TEXT, 
            destination TEXT, 
            unitFare INTEGER, 
            vehicleId INTEGER, 
            startTime TEXT, 
            driverId INTEGER, 
            createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY(vehicleId) REFERENCES vehicles(id),
            FOREIGN KEY(driverId ) REFERENCES drivers(id)
          )
        ''');
        
        await createGenesisTrip(); 
      },
      version: 1,
    );
  }

  // Create a Genesis Trip and add to the trips table
  Future<void> createGenesisTrip() async {

    final genesisTrip = Trip(
      id: 1,
      uuid: const Uuid().v4(),
      source: 'NRB',
      destination: 'MSA',
      unitFare: 1000,
      vehicleId: 1,
      startTime: '8:00AM',
      driverId: '0X001',
      createdAt: DateTime.parse('2022-01-01 00:00:00').toString(),
    );
    
    await insertTrip(genesisTrip);
  }

  // Define a function that inserts trips into the database
  Future<dynamic> insertTrip(dynamic trip) async {
    // Get a reference to the database.
    final db = database;

    // Insert the Trip into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same trip is inserted twice.
    //
    // In this case, replace any previous data.
    try{
      await db.insert(
        'trips',
        trip.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch(e){
      print(e);
    }
  }

  // A method that retrieves all the trips from the trips table.
  Future<List<Trip>> trips() async {
    // Get a reference to the database.
    final db = database;

    // Query the table for all The Trips.
    final List<Map<String, dynamic>> maps = await db.query('trips');

    // Convert the List<Map<String, dynamic> into a List<Trip
    return List.generate(maps.length, (i) {
      return Trip(
        id: maps[i]['id'],
        uuid: maps[i]['uuid'],
        source: maps[i]['source'],
        destination: maps[i]['destination'],
        unitFare: maps[i]['unitFare'],
        vehicleId: maps[i]['vehicleId'],
        startTime: maps[i]['startTime'],
        driverId: maps[i]['driverId'],
        createdAt: maps[i]['createdAt'],
      );
    });
  }

  Future<void> updateTrip(Trip trip) async {
    // Get a reference to the database.
    final db = database;

    // Update the given Trip.
    await db.update(
      'trips',
      trip.toMap(),
      // Ensure that the Trip has a matching id.
      where: 'id = ?',
      // Pass the Trip's id as a whereArg to prevent SQL injection.
      whereArgs: [trip.id],
    );
  }

  Future<void> deleteTrip(int id) async {
    // Get a reference to the database.
    final db = database;

    // Remove the Trip from the database.
    await db.delete(
      'trips',
      // Use a `where` clause to delete a specific trip.
      where: 'id = ?',
      // Pass the Trip's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteAllTrips() async {
    // Get a reference to the database.
    final db = database;

    // Remove the Trip from the database.
    await db.delete(
      'trips',
      // null value deletes all the trips
      where: null,
    );
  }

  Future<void> closeDB() async {
    final db = database;

    await db.close();
  }
  
}