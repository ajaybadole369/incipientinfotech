import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const dbName = 'userdataBases.db';
  static const dbVersion = 1;
  static const dbTable = 'tableUsers';
  static const colId = 'id';
  static const colName = 'name';
  static const colUsername = 'username';
  static const colEmail = 'email';
  static const colAdd = 'address';
  static const colPhone = 'phone';
  static const colWebsite = 'website';

  // constructor
  static final DBHelper dbHelper = DBHelper();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  Future initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE $dbTable(
$colId INTEGER PRIMARY KEY,
$colName TEXT NOT NULL,
$colEmail TEXT NOT NULL,
$colUsername TEXT NOT NULL,
$colAdd TEXT NOT NULL,
$colPhone TEXT NOT NULL,
$colWebsite TEXT NOT NULL)
''');
  }

  //insert
  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await dbHelper.database;
    return await db?.insert(dbTable, row);
  }

  // read
  Future<List<Map<String, dynamic>>> read() async {
    Database? db = await dbHelper.database;
    return await db!.query(dbTable);
  }

  //update

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await dbHelper.database;
    int id = row[colId];
    return await db!.update(dbTable, row, where: "$colId=?", whereArgs: [id]);
  }

  //delete

  Future<int> delete(int id) async {
    Database? db = await dbHelper.database;
    return await db!.delete(dbTable, where: "$colId=?", whereArgs: [id]);
  }
}
