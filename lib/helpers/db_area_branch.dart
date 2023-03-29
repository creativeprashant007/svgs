import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelperBranch {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'branch.db'),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE area_data(branchid TEXT PRIMARY KEY,pin TEXT,area TEXT )',
      );
    }, version: 1);
  }

  static Future<void> insertAreaBranchId(
    String table,
    Map<String, Object> data,
  ) async {
    final db = await DBHelperBranch.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(
    String table,
  ) async {
    final db = await DBHelperBranch.database();
    return db.query(table);
  }

  static Future<int> deleteUser() async {
    var dbClient = await DBHelperBranch.database();
    int res = await dbClient.delete("area_data");
    return res;
  }

}
