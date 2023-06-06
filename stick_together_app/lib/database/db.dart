import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DB {
  //construtor com acesso privado
  DB_();
  //criar uma isntancia de DB
  static final DB instance = DB_();
  //Instancia do Sqlite
  static Database? _database;
  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'sticky.db'),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(db, versao) async {
    await db.execute(_account);
    await db.execute(_stickyNote);
    //await db.execute(_note);
  }

  String get _account => '''
    CREATE TABLE account(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userName = TEXT,
      email = TEXT,
      password = TEXT,
      phone = TEXT,
      photo BLOB
    )
  ''';
  String get _stickyNote => '''
    CREATE TABLE note(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId = INTEGER,
      note = TEXT,
      location = TEXT,
      date = TEXT,
      description = TEXT

    )
  ''';
}
