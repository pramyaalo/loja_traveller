import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HoteldatabaseHelper {
  static final HoteldatabaseHelper instance = HoteldatabaseHelper._privateConstructor();
  static Database? _database;

  HoteldatabaseHelper._privateConstructor();

  Future<void> reopenDatabase() async {
    _database = await _initDatabase();
  }

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'hoteladults.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE hoteladults(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            firstName TEXT,
            surname TEXT,
            dob TEXT
          )
        ''');
      },
    );
  }

  Future<void> inserthotelAdults(Map<String, dynamic> travellerData) async {
    final db = await database;
    await db.insert('hoteladults', travellerData, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> gethotelAdults() async {
    final db = await database;
    return await db.query('hoteladults');
  }

  Future<void> deletehotelAdults(int id) async {
    final db = await database;
    await db.delete('hoteladults', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updatehotelAdults(int id, Map<String, dynamic> updatedData) async {
    final db = await database;
    await db.update('hoteladults', updatedData, where: 'id = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>?> fetchhotelAdultData(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('hoteladults', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteAllRecords() async {
    final db = await database;
    await db.delete('hoteladults');
  }


  Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), 'hoteladults.db');
    await deleteDatabase(path);
    _database = null;
    print("Deleted database at: $path");
  }
}
