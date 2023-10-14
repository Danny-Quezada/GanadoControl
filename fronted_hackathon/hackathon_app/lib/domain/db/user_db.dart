import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDB {
  static UserDB _userDb = new UserDB._internal();
  static UserDB get instance => _userDb;
  UserDB._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _init();
    return _database!;
  }

  Future<Database> _init() async {
    return await openDatabase(
      join(await getDatabasesPath(), "user_database.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE User(id INTEGER, cargo TEXT, nombreUsuario TEXT, contraseña TEXT, correo TEXT)");
      },
    );
  }
}
