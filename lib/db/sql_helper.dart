import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class SqlHelper {

  static Future<void> createTable(sql.Database database) async {
    await database.execute( """
      CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT NOT NULL,
        desc TEXT NOT NULL,
        date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """
    );
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'tesha.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      }
    );
  }
  static Future<void> saveNote(String title, String desc) async {
    final db = await SqlHelper.db();
    final data = {'title': title, 'desc': desc};
    await db.insert('items', data, conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await SqlHelper.db();
    return db.query('items',orderBy: 'id');
  }
}
