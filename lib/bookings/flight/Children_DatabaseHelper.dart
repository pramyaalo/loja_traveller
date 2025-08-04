import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ChildrenDatabaseHelper {
  static final ChildrenDatabaseHelper instance = ChildrenDatabaseHelper._privateConstructor();
  static Database? _database;



  ChildrenDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'childrens.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE childrens(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            firstName TEXT,
            surname TEXT,
            dob TEXT,
            documentType TEXT,
            documentNumber TEXT,
            expiryDate TEXT
          )''');
      },
    );
  }

  Future<void> insertChildrens(Map<String, dynamic> travellerData) async {
    final db = await database;
    await db.insert(
      'childrens',            // The table name
      travellerData,       // The map containing traveller data
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getChildrens() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('childrens');
    return maps; // Return the entire list of maps (each adult's data)
  }

  Future<void> deleteChildrens(int id) async {
    final db = await database;
    await db.delete(
      'childrens',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update existing adult data
  // This assumes each adult has a unique `id` field in your database.
  Future<void> updateChildrens(int id, Map<String, dynamic> updatedData) async {
    final db = await database;
    await db.update(
      'childrens',
      updatedData,
      where: 'id = ?', // Ensure you're updating by unique `id`
      whereArgs: [id], // Pass the unique `id` here
    );
  }

  Future<Map<String, dynamic>?> fetchAdultData(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'childrens',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }
  Future<void> deleteAllRecords(String tableName) async {
    final db = await database; // Assuming you've initialized the database
    await db.delete(tableName); // Use the tableName parameter instead of hardcoding 'Childrens'
  }



}

