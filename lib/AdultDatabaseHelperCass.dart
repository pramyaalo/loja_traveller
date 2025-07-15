import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AdultDatabaseHelper {
  static final AdultDatabaseHelper instance = AdultDatabaseHelper._privateConstructor();
  static Database? _database;

  AdultDatabaseHelper._privateConstructor();
  Future<void> reopenDatabase() async {
    _database = await _initDatabase();
  }
  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'adults.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE adults (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            firstName TEXT,
            middleName TEXT,
            surname TEXT,
            dob TEXT,
            gender TEXT,
            documentType TEXT,
            documentNumber TEXT,
            issueDate TEXT,
            expiryDate TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertAdults(Map<String, dynamic> data) async {
    final db = await database;
    print("Insert: DB is open = ${db.isOpen}");
    await db.insert('adults', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateAdults(int id, Map<String, dynamic> updatedData) async {
    final db = await database;
    await db.update('adults', updatedData, where: 'id = ?', whereArgs: [id]);
  }



  Future<Map<String, dynamic>?> fetchAdultData(int id) async {
    final db = await database;
    final result = await db.query('adults', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteAdults(int id) async {
    final db = await database;
    await db.delete('adults', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getAdults() async {
    final db = await database;
    return await db.query('adults');
  }

  Future<void> deleteAllRecords(String tableName) async {
    final db = await database; // Assuming you've initialized the database
    await db.delete(tableName); // Use the tableName parameter instead of hardcoding 'adults'
  }

  Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), 'adults.db');
    await deleteDatabase(path);
    _database = null; // reset database reference
    print("Deleted database at: $path");
  }
}
