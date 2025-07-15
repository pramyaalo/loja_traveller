import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HoteldatabaseHelper {
  static final HoteldatabaseHelper instance = HoteldatabaseHelper._privateConstructor();
  static Database? _database;

  HoteldatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'hoteladults.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE hoteladults(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            firstName TEXT,
            surname TEXT,
            dob TEXT,
            mobileNumber TEXT,
            country TEXT   
          )
        ''');
      },
    );
  }

  Future<void> inserthotelAdults(Map<String, dynamic> travellerData) async {
    final db = await database;
    await db.insert(
      'hoteladults',            // The table name
      travellerData,           // The map containing traveller data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> gethotelAdults() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('hoteladults');
    return maps; // Return the entire list of maps (each adult's data)
  }

  Future<void> deletehotelAdults(int id) async {
    final db = await database;
    await db.delete(
      'hoteladults',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updatehotelAdults(int id, Map<String, dynamic> updatedData) async {
    final db = await database;
    await db.update(
      'hoteladults',
      updatedData,
      where: 'id = ?', // Ensure you're updating by unique `id`
      whereArgs: [id], // Pass the unique `id` here
    );
  }

  Future<Map<String, dynamic>?> fetchhotelAdultData(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'hoteladults',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteAllhotelRecords(String tableName) async {
    final db = await database; // Assuming you've initialized the database
    await db.delete(tableName); // Use the tableName parameter instead of hardcoding 'adults'
  }
}
