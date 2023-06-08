import 'dart:html';

import 'package:sqflite/sqflite.dart' as sql;
//import 'package:path/path.dart';
//import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/foundation.dart';

class DataBase {
  static Future<void> CreateTable(sql.Database database) async {
    await database.execute("""CREATE TABLE account( 
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        userName = TEXT,
        email = TEXT,
        password = TEXT,
        phone = TEXT,
        photo BLOB)
        """);

    await database.execute("""CREATE TABLE note( 
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      userId = INTEGER,
      note = TEXT,
      location = TEXT,
      date = TEXT,
      )
        """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'sticky.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await CreateTable(database);
      },
    );
  }

  static Future<int> createAccount(String userName, String email,
      String password, String? phone, Blob? photo) async {
    final db = await DataBase.db();
    final data = {
      'userName': userName,
      'email': email,
      'password': password,
      'phone': phone,
      'photo': photo
    };
    final id = await db.insert('account', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAccount(
      String userName, String password) async {
    final db = await DataBase.db();
    return db.query('account',
        where: "userName= ? and password = ?",
        whereArgs: [userName, password],
        limit: 1);
  }

  static Future<int> updateProfil(int id, String userName, String email,
      String password, String? phone, Blob? photo) async {
    final db = await DataBase.db();
    final data = {
      'userName': userName,
      'email': email,
      'password': password,
      'phone': phone,
      'photo': photo
    };
    final result =
        await db.update('account', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

//Note:
  static Future<int> createNote(
    int userId,
    String note,
    String location,
    String? date,
  ) async {
    final db = await DataBase.db();
    final data = {
      'userId': userId,
      'note': note,
      'location': location,
      'date': date
    };
    final id = await db.insert('note', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await DataBase.db();
    return db.query('note', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getNote(int id) async {
    final db = await DataBase.db();
    return db.query('note', where: "id = ?", whereArgs: [id]);
  }

  static Future<int> updateNote(
    int id,
    String note,
    String location,
    String? date,
  ) async {
    final db = await DataBase.db();
    final data = {'note': note, 'location': location, 'date': date};
    final result =
        await db.update('note', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteNote(int id) async {
    final db = await DataBase.db();
    try {
      await db.delete("note", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an note: $err");
    }
  }
}
