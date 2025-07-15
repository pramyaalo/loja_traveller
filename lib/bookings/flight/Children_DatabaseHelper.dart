import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ChildrenDatabaseHelper {
  static final ChildrenDatabaseHelper instance = ChildrenDatabaseHelper._privateConstructor();
  static Database? _database;

  ChildrenDatabaseHelper._privateConstructor();

  Future<void> reopenDatabase() async {
    _database = await _initDatabase();
  }

  Future<Database> get database async {
    if (_database != null && _database!.isOpen) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'children.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE children (
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
        await db.execute('DROP TABLE IF EXISTS children');
        await db.execute('''
          CREATE TABLE children (
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

  Future<void> insertChildrens(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert('children', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateChildrens(int id, Map<String, dynamic> updatedData) async {
    final db = await database;
    await db.update('children', updatedData, where: 'id = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>?> fetchAdultData(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('children', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> deleteChild(int id) async {
    final db = await database;
    await db.delete('children', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllRecords(String tableName) async {
    final db = await database;
    await db.delete(tableName);
  }

  Future<List<Map<String, dynamic>>> getChildrens() async {
    final db = await database;
    return await db.query('children');
  }
  Future<void> deleteDatabaseFile() async {
    final path = join(await getDatabasesPath(), 'children.db');
    await deleteDatabase(path);
    print("Deleted children DB at: $path");
  }

  Future<void> deleteChildrens(int id) async {
    final db = await database;
    await db.delete(
      'children',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
