import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/appointment.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService());

class DatabaseService {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await openDatabase(
      join(await getDatabasesPath(), 'appointments.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE appointments(id INTEGER PRIMARY KEY, title TEXT, customerName TEXT, company TEXT, description TEXT, dateTime TEXT, latitude REAL, longitude REAL)',
        );
      },
      version: 1,
    );

    return _db!;
  }

  Future<List<Appointment>> getAppointments() async {
    final db = await database;
    final maps = await db.query('appointments');
    return maps.map((map) => Appointment.fromMap(map)).toList();
  }

  Future<int> insertAppointment(Appointment appointment) async {
    final db = await database;
    return db.insert('appointments', appointment.toMap());
  }

  Future<void> updateAppointment(Appointment appointment) async {
    final db = await database;
    await db.update(
      'appointments',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  Future<void> deleteAppointment(int id) async {
    final db = await database;
    await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}