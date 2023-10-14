import 'package:hackathon_app/domain/db/user_db.dart';
import 'package:hackathon_app/domain/interfaces/imodel.dart';
import 'package:hackathon_app/domain/models/Entities/user.dart';
import 'package:sqflite/sql.dart';

class UserRepositoryDB implements IModel<User> {
  @override
  Future<int> create(User t) async {
    var db = await UserDB.instance.database;
    try {
      await db.delete("User", where: "id = ? ", whereArgs: [t.userId]);
      return await db.insert("User", t.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw Exception("Error in internal db");
    }
  }

  @override
  Future<bool> delete(User t) async {
    var db = await UserDB.instance.database;
    try {
      return await db.delete("User", where: "id = ?", whereArgs: [t.userId]) ==
              0
          ? false
          : true;
    } catch (e) {
      throw Exception("Error in internal db");
    }
  }

  @override
  Future<List<User>> read() async {
    List<User> users = [];
    var db = await UserDB.instance.database;
    try {
      List<Map> list = await db.rawQuery('SELECT * FROM User');

      list.forEach((element) {
        User user = User.fromJson(element);
        users.add(user);
      });
      return users;
    } catch (e) {
      throw Exception("Error in internal db");
    }
  }

  @override
  Future<bool> update(User t) async {
    var db = await UserDB.instance.database;
    try {
      return await db.update("User", t.toJson(),
                  where: "id = ?", whereArgs: [t.userId]) ==
              0
          ? false
          : true;
    } catch (e) {
      throw Exception("Error in internal db");
    }
  }
}
