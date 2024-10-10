
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _database;

  DatabaseHelper();

  Future<Database> get database async {
    if(_database !=null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB
    );
  } 

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      address TEXT NOT NULL,
      phone TEXT NOT NULL
    )

  ''');

  }

  //methods to CRUD
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
    
  }

  Future<List<Map<String, dynamic>>> getUser() async {
    final db = await database;
    return await db.query('users');
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    final id = user['id'];
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<int> deleteUser(int id) async{
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id]      
    );
  }


  Future<void> close() async {
    final db = await database;
    await db.close();
  }

}