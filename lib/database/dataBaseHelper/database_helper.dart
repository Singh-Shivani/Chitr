import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class FavImageDatabaseHelper {
  static final _databaseName = "chitr.db";
  static final _databaseVersion = 5;

  static final table = 'fav_images';
  static final columnId = 'id';
  static final imageid = 'imageid';
  static final raw = 'raw';
  static final full = 'full';
  static final regular = 'regular';
  static final small = 'small';
  static final thumb = 'thumb';
  static final blurHash = 'blurHash';

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
            $raw TEXT NOT NULL,
            $full TEXT NOT NULL,
            $regular TEXT NOT NULL,
            $small TEXT NOT NULL,
            $thumb TEXT NOT NULL,
            $blurHash TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;

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

  Future<int> deleteFav(String id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$imageid = ?', whereArgs: [id]);
  }
}
