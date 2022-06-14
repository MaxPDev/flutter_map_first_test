import 'dart:developer';

import 'package:fr_piscadev_osmtest/models/velostan_carto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VelostanDatabase {
  static final VelostanDatabase instance = VelostanDatabase._init();

  static Database? _database;

  VelostanDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('velostan.db');
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
    final realType = 'REAL';

    await db.execute('''
CREATE TABLE $tableVelostan (
  ${VelostanFields.id} $idType,
  ${VelostanFields.name} $textType,
  ${VelostanFields.address} $textType,
  ${VelostanFields.lat} $realType,
  ${VelostanFields.lng} $realType,
  ${VelostanFields.open} $boolType,
  ${VelostanFields.bonus} $boolType
)
''');
  }

  Future<int> createVelostanCarto(VelostanCarto velostanCarto) async {
    final db = await instance.database;

    final idBack = await db.insert(tableVelostan, velostanCarto.toJson());
    // print("retour de create : $idBack");
    // print(parking.toJson());
    // return getParking(parking.id!);
    return idBack;
  }

  Future<VelostanCarto> getVelostanCarto(String id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableVelostan,
      columns: VelostanFields.values,
      where: '${VelostanFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      inspect(maps);
      return VelostanCarto.fromDBJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<VelostanCarto>> getAllVelostanCarto() async {
    final db = await instance.database;

    // final orderBy = '${ParkingFields.id} ASC';

    final result = await db.query(tableVelostan);

    return result.map((json) => VelostanCarto.fromDBJson(json)).toList();
  }

  Future<int> update(VelostanCarto velostanCarto) async {
    final db = await instance.database;

    return db.update(
      tableVelostan,
      velostanCarto.toJson(),
      where: '${VelostanFields.id} = ?',
      whereArgs: [velostanCarto.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableVelostan,
      where: '${VelostanFields.id} = ?',
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
