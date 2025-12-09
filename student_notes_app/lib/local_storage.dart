import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'note.dart';

class LocalStorage {
  static const _notesKey = 'notes';
  static const _darkKey = 'isDarkMode';

  static Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(notes.map((n) => n.toMap()).toList());
    await prefs.setString(_notesKey, jsonString);
  }

  static Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_notesKey);
    if (jsonString == null) return [];
    final List list = jsonDecode(jsonString);
    return list.map((e) => Note.fromMap(e)).toList();
  }

  static Future<void> saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_darkKey, value);
  }

  static Future<bool> loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkKey) ?? false;
  }
}
