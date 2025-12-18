import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  String filter = "all";
  final TodoService _service = TodoService();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final data = await _service.loadTodos();
    setState(() {
      todos = data;
    });
  }

  Future<void> _save() async => _service.saveTodos(todos);

  // ========== CRUD ==========
  void _addTodo(String title) {
    setState(() {
      todos.add(Todo(
        id: const Uuid().v4(),
        title: title,
        createdAt: DateTime.now(),
      ));
    });
    _save();
  }

  void _editTodo(String id, String newTitle) {
    setState(() {
      final todo = todos.firstWhere((t) => t.id == id);
      todo.title = newTitle;
    });
    _save();
  }

  void _toggleStatus(String id) {
    setState(() {
      final todo = todos.firstWhere((t) => t.id == id);
      todo.isCompleted = !todo.isCompleted;
    });
    _save();
  }

  void _delete(String id) {
    setState(() {
      todos.removeWhere((t) => t.id == id);
    });
    _save();
  }

  // ========= FILTER =========
  List<Todo> get filteredTodos {
    switch (filter) {
      case "completed":
        return todos.where((t) => t.isCompleted).toList();
      case "pending":
        return todos.where((t) => !t.isCompleted).toList();
      default:
        return todos;
    }
  }

  // ========= DIALOG =========
  void _showTodoDialog({Todo? todo}) {
    final controller = TextEditingController(text: todo?.title ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(todo == null ? "Tambah Todo" : "Edit Todo"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
              labelText: "Nama Todo",
              border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                if (todo == null) {
                  _addTodo(controller.text);
                } else {
                  _editTodo(todo.id, controller.text);
                }
                Navigator.pop(context);
              }
            },
            child: Text(todo == null ? "Tambah" : "Update"),
          ),
        ],
      ),
    );
  }

  // ========= UI =========
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        actions: [
          PopupMenuButton(
            onSelected: (val) => setState(() => filter = val),
            itemBuilder: (_) => const [
              PopupMenuItem(value: "all", child: Text("Semua")),
              PopupMenuItem(value: "completed", child: Text("Selesai")),
              PopupMenuItem(value: "pending", child: Text("Belum Selesai")),
            ],
          ),
        ],
      ),

      body: filteredTodos.isEmpty
          ? const Center(child: Text("Belum ada Todo"))
          : ListView.builder(
              itemCount: filteredTodos.length,
              itemBuilder: (_, i) {
                final todo = filteredTodos[i];
                return ListTile(
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) => _toggleStatus(todo.id),
                  ),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                      "${todo.createdAt.day}/${todo.createdAt.month}/${todo.createdAt.year}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showTodoDialog(todo: todo)),
                      IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _delete(todo.id)),
                    ],
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showTodoDialog(),
      ),
    );
  }
}
