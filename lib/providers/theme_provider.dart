import 'package:flutter/material.dart';
import '../services/db_helper.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;
  final _db = DBHelper();

  bool get isDark => _isDark;

  Future<void> loadTheme() async {
    final val = await _db.getSetting('is_dark');
    if (val != null) {
      _isDark = val == 'true';
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    notifyListeners();
    await _db.saveSetting('is_dark', _isDark.toString());
  }
}
