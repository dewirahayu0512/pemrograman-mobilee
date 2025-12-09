import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

class TodoService {
  static const String key = "todos";

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);

    if (jsonString == null) return [];

    List data = jsonDecode(jsonString);
    return data.map((e) => Todo.fromJson(e)).toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString =
        jsonEncode(todos.map((e) => e.toJson()).toList());

    await prefs.setString(key, jsonString);
  }
}
