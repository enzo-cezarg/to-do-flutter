import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'todolist.db'), onCreate: (db, version) {
      return db.execute('CREATE TABLE tasks (id TEXT PRIMARY KEY, description TEXT, taskDate INTEGER, isDone INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }

  static Future<void> deleteId(String table, String id) async {
    final db = await DbUtil.database();
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
