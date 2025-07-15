import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class InfantDatabaseHelper {
  static final InfantDatabaseHelper instance = InfantDatabaseHelper._privateConstructor();
  static Database? _database;

  InfantDatabaseHelper._privateConstructor();
  Future<void> reopenDatabase() async {
    if (_database == null || !_database!.isOpen) {
      _database = await _initDatabase();
      print("DB reopened successfully.");
    }
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'infants.db');
    return await openDatabase(
      path,
      version: 2, // ⬅️ Increased version to recreate the table with new columns
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE infants(
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
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS infants');
        await db.execute('''
          CREATE TABLE infants(
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

  Future<void> insertInfant(Map<String, dynamic> travellerData) async {
    final db = await database;
    await db.insert(
      'infants',
      travellerData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getInfant() async {
    final db = await database;
    return await db.query('infants');
  }

  Future<void> deleteInfant(int id) async {
    final db = await database;
    await db.delete(
      'infants',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateInfant(int id, Map<String, dynamic> updatedData) async {
    final db = await database;
    await db.update(
      'infants',
      updatedData,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// ✅ Correct method name for fetching infant by ID
  Future<Map<String, dynamic>?> fetchInfantData(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'infants',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteAllRecords(String tableName) async {
    final db = await database;
    await db.delete(tableName);
  }
  Future<void> deleteDatabaseFile() async {
    final path = join(await getDatabasesPath(), 'infants.db');
    await deleteDatabase(path);
    _database = null; // ✅ Important: reset instance
    print("Infant database deleted at: $path");
  }


}
