import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class FavImageDatabaseHelper {
  static final _databaseName = "chitr.db";
  static final _databaseVersion = 1;

  static final table = 'fav_images';
  static final columnId = 'id';
  static final imageid = 'imageid';
  static final smallImage = 'smallImage';
  static final fullImage = 'fullImage';
  static final dwonloadLink = 'dwonloadLink';

  FavImageDatabaseHelper._privateConstructor();
  static final FavImageDatabaseHelper instance =
      FavImageDatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $imageid TEXT NOT NULL,
            $smallImage TEXT NOT NULL,
            $fullImage TEXT NOT NULL,
            $dwonloadLink TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    // Database db = await instance.database;
    // return await db.query(table);
    Database db = await instance.database;
    // return await db.query(table);
    final ret =
        await db.rawQuery('SELECT * FROM $table ORDER BY $columnId DESC');
    return ret;
  }

  Future<List<Map<String, dynamic>>> findObjects(String query) async {
    Database db = await instance.database;
    final ret = await db.rawQuery(
        'SELECT *, COUNT(*) as watchedTimes FROM $table where = ?',
        ['%$query%']);
    return ret;
  }

  Future<List<Map>> findObjects22(String query) async {
    Database db = await instance.database;
    final ret =
        await db.rawQuery('SELECT * FROM $table WHERE $imageid=?', [query]);
    return ret;
  }

  Future hasData(String query) async {
    Database db = await instance.database;
    final ret =
        await db.rawQuery('SELECT * FROM $table WHERE $imageid=?', [query]);
    // print("WOWOWO");
    // print(ret);
    if (ret.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteFav(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
