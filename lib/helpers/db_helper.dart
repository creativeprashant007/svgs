import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'uniqueId.db'),
        onCreate: (db, version) {
      return db.execute('CREATE TABLE unique_id(id TEXT PRIMARY KEY)');
    }, version: 1);
  }

  static Future<void> insertUniqueId(
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

  static Future<List<Map<String, dynamic>>> getData(
    String table,
  ) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
