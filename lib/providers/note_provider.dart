import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/note_model.dart';
import '../services/db_helper.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  final _db = DBHelper();
  final _uuid = const Uuid();

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    final db = await _db.database;
    final maps = await db.query('notes', orderBy: 'updatedAt DESC');
    _notes.clear();
    _notes.addAll(maps.map((e) => Note.fromMap(e)));
    notifyListeners();
  }

  Future<void> addNote(
    String title,
    String content, {
    int colorIndex = 0,
  }) async {
    final note = Note(
      id: _uuid.v4(),
      title: title,
      content: content,
      colorIndex: colorIndex,
      updatedAt: DateTime.now(),
    );
    final db = await _db.database;
    await db.insert('notes', note.toMap());
    _notes.insert(0, note);
    notifyListeners();
  }

  Future<void> editNote(
    String id,
    String title,
    String content, {
    int? colorIndex,
  }) async {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index == -1) return;
    _notes[index].title = title;
    _notes[index].content = content;
    if (colorIndex != null) _notes[index].colorIndex = colorIndex;
    _notes[index].updatedAt = DateTime.now();
    final db = await _db.database;
    await db.update(
      'notes',
      _notes[index].toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((n) => n.id == id);
    final db = await _db.database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    notifyListeners();
  }
}
