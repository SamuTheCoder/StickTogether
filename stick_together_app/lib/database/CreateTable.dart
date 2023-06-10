import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DB {
  DB._privateConstructor();
  static final DB instance = DB._privateConstructor();
  static Database? _database;
  /*
  get database async {
    if (_database != null) return _database;
    return await _initDatabase();
  }
  */
  static Future<Database> _initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'stick_together.db');

    return _database = await openDatabase(
      path,
      version: 1,
      onCreate: createTable,
    );
  }

  static Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  static Future<void> createTable(db, versao) async {
    await db.execute("""CREATE TABLE account( 
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        user_name TEXT,
        email TEXT,
        password TEXT
        )
        """);

    await db.execute("""CREATE TABLE note( 
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      user_id INTEGER,
      note TEXT,
      location TEXT,
      date TEXT,
      FOREIGN KEY (user_id) REFERENCES account (id) ON DELETE CASCADE
      )
        """);
  }

  /// initialize the database

  static Future<int> createAccount(
      String userName, String email, String password, String? phone) async {
    //await _initDatabase();
    //final Database db = await DB.instance.database;
    final data = {
      'user_name': userName,
      'email': email,
      'password': password,
    };
    final Database database = await getDatabase();
    final id = await database.insert('account', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAccount(
      String userName, String password) async {
    //await _initDatabase();
    final Database database = await getDatabase();
    return database.query('account',
        where: "user_name= ? and password = ?",
        whereArgs: [userName, password],
        limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getUser(String userName) async {
    final Database database = await getDatabase();
    return database.query('account',
        where: "user_name= ?", whereArgs: [userName], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getAccounts() async {
    final Database database = await getDatabase();
    return database.query('account', orderBy: 'id');
  }

  static Future<int> updateProfile(int id, String userName, String email,
      String password, String? phone) async {
    final Database database = await getDatabase();
    final data = {
      'user_name': userName,
      'email': email,
      'password': password,
    };
    final result = await database
        .update('account', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

//Note:
  static Future<int> createNote(
    int userId,
    String note,
    String location,
    String? date,
  ) async {
    final Database database = await getDatabase();
    final data = {
      'user_id': userId,
      'note': note,
      'location': location,
      'date': date
    };
    final id = await database.insert('note', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final Database database = await getDatabase();
    return database.query('note', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getNote(int id) async {
    final Database database = await getDatabase();
    return database.query('note', where: "id = ?", whereArgs: [id]);
  }

  static Future<int> updateNote(
    int id,
    String note,
    String location,
    String? date,
  ) async {
    final Database database = await getDatabase();
    final data = {'note': note, 'location': location, 'date': date};
    final result =
        await database.update('note', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteNote(int id) async {
    final Database database = await getDatabase();
    try {
      await database.delete("note", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
