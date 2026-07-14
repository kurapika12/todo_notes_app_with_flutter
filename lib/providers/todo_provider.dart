import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';
import '../services/db_helper.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];
  final _db = DBHelper();
  final _uuid = const Uuid();

  List<Todo> get todos => _todos;

  Future<void> loadTodos() async {
    final db = await _db.database;
    final maps = await db.query('todos', orderBy: 'createdAt DESC');
    _todos.clear();
    _todos.addAll(maps.map((e) => Todo.fromMap(e)));
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    final todo = Todo(id: _uuid.v4(), title: title, createdAt: DateTime.now());
    final db = await _db.database;
    await db.insert('todos', todo.toMap());
    _todos.insert(0, todo);
    notifyListeners();
  }

  Future<void> toggleTodo(String id) async {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _todos[index].isDone = !_todos[index].isDone;
    final db = await _db.database;
    await db.update(
      'todos',
      _todos[index].toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> editTodo(String id, String newTitle) async {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _todos[index].title = newTitle;
    final db = await _db.database;
    await db.update(
      'todos',
      _todos[index].toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((t) => t.id == id);
    final db = await _db.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
    notifyListeners();
  }
}
