import 'package:flutter/material.dart';
import 'note_form_page.dart';
import 'note.dart';
import 'local_storage.dart';

class HomePage extends StatefulWidget {
  final bool isDark;
  final Function(bool) onThemeChanged;

  const HomePage({super.key, required this.isDark, required this.onThemeChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> _notes = [];
  String _filter = "Semua";

  final categories = ["Semua", "Kuliah", "Organisasi", "Pribadi", "Lain-lain"];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final data = await LocalStorage.loadNotes();
    setState(() {
      _notes = data;
      _sortNotes();
    });
  }

  void _sortNotes() {
    _notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> _saveNotes() async => LocalStorage.saveNotes(_notes);

  Future<void> _addNote() async {
    final note = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => const NoteFormPage()),
    );
    if (note != null) {
      setState(() {
        _notes.add(note);
        _sortNotes();
      });
      _saveNotes();
    }
  }

  Future<void> _edit(int index) async {
    final old = _notes[index];
    final updated = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => NoteFormPage(existingNote: old)),
    );
    if (updated != null) {
      setState(() {
        _notes[index] = updated;
        _sortNotes();
      });
      _saveNotes();
    }
  }

  void _delete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Hapus catatan ini?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          TextButton(
            onPressed: () {
              setState(() {
                _notes.removeAt(index);
                _sortNotes();
              });
              _saveNotes();
              Navigator.pop(context);
            },
            child: const Text("Hapus"),
          )
        ],
      ),
    );
  }

  IconData iconFor(String c) {
    switch (c) {
      case "Kuliah":
        return Icons.school;
      case "Organisasi":
        return Icons.group;
      case "Pribadi":
        return Icons.person;
      default:
        return Icons.label;
    }
  }

  List<Note> get filteredNotes {
    if (_filter == "Semua") return _notes;
    return _notes.where((n) => n.category == _filter).toList();
  }

  // Format tanggal
  String fmt(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Notes"),
        actions: [
          Switch(
            value: widget.isDark,
            onChanged: widget.onThemeChanged,
          )
        ],
      ),
      body: Column(
        children: [
          // FILTER
          Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButtonFormField(
              value: _filter,
              items: categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _filter = v!),
              decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Filter Kategori"),
            ),
          ),

          Expanded(
            child: filteredNotes.isEmpty
                ? const Center(child: Text("Belum ada catatan"))
                : ListView.builder(
                    itemCount: filteredNotes.length,
                    itemBuilder: (_, i) {
                      final note = filteredNotes[i];
                      final originalIndex = _notes.indexOf(note);

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: CircleAvatar(child: Icon(iconFor(note.category))),
                          title: Text(note.title),
                          subtitle: Text("${note.category} • ${fmt(note.createdAt)}\n${note.content}",
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                          onTap: () => _edit(originalIndex),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(icon: const Icon(Icons.edit), onPressed: () => _edit(originalIndex)),
                              IconButton(icon: const Icon(Icons.delete), onPressed: () => _delete(originalIndex)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
