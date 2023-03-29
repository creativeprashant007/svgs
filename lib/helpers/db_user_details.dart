import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'userData.db'),
        onCreate: (db, version) {
      return db.execute(
        //  'CREATE TABLE user_data(memberId TEXT PRIMARY KEY,name TEXT,email TEXT,phone TEXT,areaId TEXT, areaName TEXT )',
        'CREATE TABLE user_data(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, memberId TEXT ,name TEXT,email TEXT,phone TEXT,areaId TEXT, areaName TEXT )',
      );
    }, version: 1);
  }

  static Future<void> insertUserData(
    String table,
    Map<String, Object> data,
  ) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  Future<int> updateUserData(
    String table,
    Map<String, Object> data,
    String id,
  ) async {
    final db = await DBHelper.database();
    int itemCount = await db.update(
      table,
      data,
      where: 'id=?',
      whereArgs: [id],
    );
    print(itemCount);
    return itemCount;
  }

  static Future<List<Map<String, dynamic>>> getData(
    String table,
  ) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<int> deleteUser() async {
    var dbClient = await DBHelper.database();
    int res = await dbClient.delete("user_data");
    return res;
  }
}
