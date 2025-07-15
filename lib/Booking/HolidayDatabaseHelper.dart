import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HolidayDatabaseHelper {
  static final HolidayDatabaseHelper instance = HolidayDatabaseHelper._privateConstructor();
  static Database? _database;

  HolidayDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'holidayadults.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE holidayadults(
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

  Future<void> insertholidayAdults(Map<String, dynamic> travellerData) async {
    final db = await database;
    await db.insert(
      'holidayadults',            // The table name
      travellerData,           // The map containing traveller data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getholidayAdults() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('holidayadults');
    return maps; // Return the entire list of maps (each adult's data)
  }

  Future<void> deleteholidayAdults(int id) async {
    final db = await database;
    await db.delete(
      'holidayadults',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateholidayAdults(int id, Map<String, dynamic> updatedData) async {
    final db = await database;
    await db.update(
      'holidayadults',
      updatedData,
      where: 'id = ?', // Ensure you're updating by unique `id`
      whereArgs: [id], // Pass the unique `id` here
    );
  }

  Future<Map<String, dynamic>?> fetchholidayAdultData(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'holidayadults',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteAllholidayRecords(String tableName) async {
    final db = await database; // Assuming you've initialized the database
    await db.delete(tableName); // Use the tableName parameter instead of hardcoding 'adults'
  }
}
