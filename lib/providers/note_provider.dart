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
    final maps = await db.query(
      'notes',
      orderBy: 'isPinned DESC, sortOrder ASC, updatedAt DESC',
    );
    _notes.clear();
    _notes.addAll(maps.map((e) => Note.fromMap(e)));
    notifyListeners();
  }

  void _sortNotes() {
    _notes.sort((a, b) {
      if (a.isPinned != b.isPinned) {
        return b.isPinned ? -1 : 1; // pinned first
      }
      if (a.sortOrder != b.sortOrder) {
        return a.sortOrder.compareTo(b.sortOrder);
      }
      return b.updatedAt.compareTo(a.updatedAt); // latest first
    });
  }

  Future<void> addNote(
    String title,
    String content, {
    int colorIndex = 0,
    bool isPinned = false,
  }) async {
    final note = Note(
      id: _uuid.v4(),
      title: title,
      content: content,
      colorIndex: colorIndex,
      isPinned: isPinned,
      updatedAt: DateTime.now(),
    );
    final db = await _db.database;
    await db.insert('notes', note.toMap());
    _notes.insert(0, note);
    _sortNotes();
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
    _notes[index].sortOrder = 0; // Reset to top
    final db = await _db.database;
    await db.update(
      'notes',
      _notes[index].toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    _sortNotes();
    notifyListeners();
  }

  Future<void> togglePin(String id) async {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index == -1) return;
    _notes[index].isPinned = !_notes[index].isPinned;
    _notes[index].updatedAt = DateTime.now();
    _notes[index].sortOrder = 0; // Reset to top
    final db = await _db.database;
    await db.update(
      'notes',
      _notes[index].toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    _sortNotes();
    notifyListeners();
  }

  Future<void> reorderNotes(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Note item = _notes.removeAt(oldIndex);
    _notes.insert(newIndex, item);

    final db = await _db.database;
    for (int i = 0; i < _notes.length; i++) {
      _notes[i].sortOrder = i;
      await db.update(
        'notes',
        {'sortOrder': i},
        where: 'id = ?',
        whereArgs: [_notes[i].id],
      );
    }
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((n) => n.id == id);
    final db = await _db.database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    notifyListeners();
  }
}
