import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:test_flutter/data/models/user_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblUser = 'user';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/testaja.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tblUser (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        address TEXT,
        city TEXT
      );
    ''');
  }

  Future<int> insertUser(UserTable user) async {
    final db = await database;
    return await db!.insert(_tblUser, user.toJson());
  }

  Future<List<Map<String, dynamic>>> getListUser() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblUser);

    return results;
  }
}
