import 'dart:io';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class AppDatabase {
  Database? _database;

  // Constructor: Initialize database factory for Windows/Desktop
  AppDatabase() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDb();
    return _database!;
  }

  Future<Database> _initializeDb() async {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      final dbPath = await databaseFactory.getDatabasesPath();
      final path = join(dbPath, 'local.db');

      return await databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            // Users table
            await db.execute('''
              CREATE TABLE users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT,
                email TEXT UNIQUE,
                password TEXT
              )
            ''');

            // Todos table linked to user
            await db.execute('''
              CREATE TABLE todos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT,
                description TEXT,
                timestamp TEXT,
                completed INTEGER,
                userId INTEGER
              )
            ''');
          },
        ),
      );
    } else {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'local.db');

      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE users (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              email TEXT UNIQUE,
              password TEXT
            )
          ''');

          await db.execute('''
            CREATE TABLE todos (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT,
              timestamp TEXT,
              completed INTEGER,
              userId INTEGER
            )
          ''');
        },
      );
    }
  }

  // ---------------- USERS ----------------

  Future<int> registerUser(String name, String email, String password) async {
    final db = await database;

    final existing = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existing.isNotEmpty) {
      throw Exception("Email already registered");
    }

    return await db.insert('users', {
      'name': name,
      'email': email,
      'password': password, // ⚠️ store hashed in real apps
    });
  }

  Future<Map<String, dynamic>?> loginUser(
      String email, String password) async {
    final db = await database;

    final res = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (res.isNotEmpty) {
      return res.first; // return logged-in user
    }
    return null;
  }

  // ---------------- TODOS ----------------

  Future<int> insertTodo(int userId, String title, String description) async {
    final db = await database;
    final String formattedTimestamp =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    return await db.insert('todos', {
      'title': title,
      'description': description,
      'timestamp': formattedTimestamp,
      'completed': 0,
      'userId': userId,
    });
  }

  Future<List<Map<String, dynamic>>> getUserTodos(int userId) async {
    final db = await database;
    return await db.query(
      'todos',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<int> updateTodoStatus(int id, bool completed, int userId) async {
    final db = await database;
    return await db.update(
      'todos',
      {'completed': completed ? 1 : 0},
      where: 'id = ? AND userId = ?',
      whereArgs: [id, userId],
    );
  }

  Future<int> updateTodo(
      int id, int userId, String title, String description) async {
    final db = await database;
    return await db.update(
      'todos',
      {
        'title': title,
        'description': description,
        'timestamp': DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
      },
      where: 'id = ? AND userId = ?',
      whereArgs: [id, userId],
    );
  }

  Future<int> deleteTodo(int id, int userId) async {
    final db = await database;
    return await db.delete(
      'todos',
      where: 'id = ? AND userId = ?',
      whereArgs: [id, userId],
    );
  }
}
