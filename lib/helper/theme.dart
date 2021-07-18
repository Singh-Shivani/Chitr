import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.deepPurple,
);

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    toggleableActiveColor: Colors.deepPurple,
    accentColor: Colors.deepPurple,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.black);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme(bool val) {
    _darkTheme = val;
    _saveToPrefs(val);
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    bool theme = _prefs.getBool(key);
    if (theme != null && theme) {
      _darkTheme = true;
    } else {
      _darkTheme = false;
    }
    notifyListeners();
  }

  _saveToPrefs(bool val) async {
    await _initPrefs();
    _prefs.setBool(key, val);
  }
}
