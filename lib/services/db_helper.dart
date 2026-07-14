import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'todo_notes.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id TEXT PRIMARY KEY,
            title TEXT,
            isDone INTEGER,
            createdAt TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE notes(
            id TEXT PRIMARY KEY,
            title TEXT,
            content TEXT,
            colorIndex INTEGER DEFAULT 0,
            updatedAt TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE notes ADD COLUMN colorIndex INTEGER DEFAULT 0',
          );
        }
      },
    );
  }
}
