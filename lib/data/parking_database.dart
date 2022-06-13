import 'dart:developer';

import 'package:fr_piscadev_osmtest/models/parking.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ParkingDatabase {
  static final ParkingDatabase instance = ParkingDatabase._init();

  static Database? _database;

  ParkingDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('parkings.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'TEXT PRIMARY KEY';
    final textType = 'TEXT';
    final boolType = 'BOOLEAN';
    final integerType = 'INTEGER';

    await db.execute('''
CREATE TABLE $tableParkings (
  ${ParkingFields.id} $idType,
  ${ParkingFields.osmId} $integerType,
  ${ParkingFields.name} $textType,
  ${ParkingFields.geometryCoordinates} $textType,
  ${ParkingFields.capacity} $textType

)
''');
  }

  Future<int> createParking(Parking parking) async {
    final db = await instance.database;

    final idBack = await db.insert(tableParkings, parking.toJson());
    // print("retour de create : $idBack");
    // print(parking.toJson());
    // return getParking(parking.id!);
    return idBack;
  }

  Future<Parking> getParking(String id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableParkings,
      columns: ParkingFields.values,
      where: '${ParkingFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Parking.fromDBJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Parking>> getAllParking() async {
    final db = await instance.database;

    // final orderBy = '${ParkingFields.id} ASC';

    final result = await db.query(tableParkings);

    return result.map((json) => Parking.fromDBJson(json)).toList();
  }

  Future<int> update(Parking parking) async {
    final db = await instance.database;

    return db.update(
      tableParkings,
      parking.toJson(),
      where: '${ParkingFields.id} = ?',
      whereArgs: [parking.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableParkings,
      where: '${ParkingFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
