import 'package:flutter/material.dart';
import 'model/activity_model.dart';

class AddActivityPage extends StatefulWidget {
  final Function(Activity)? onAdd;
  const AddActivityPage({super.key, this.onAdd});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();

  String _category = 'Belajar';
  double _duration = 1;
  bool _done = false;

  final List<String> _categories = [
    'Belajar',
    'Ibadah',
    'Olahraga',
    'Hiburan',
    'Lainnya'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Kesalahan'),
          content: const Text('Nama aktivitas wajib diisi.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );
      return;
    }

    final activity = Activity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      category: _category,
      duration: _duration.toInt(),
      done: _done,
      notes: _notesController.text.trim(),
    );

    if (widget.onAdd != null) {
      widget.onAdd!(activity);
      Navigator.pop(context);
      return;
    }

    Navigator.pop(context, activity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Aktivitas Baru')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Aktivitas',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(
                  labelText: 'Kategori Aktivitas',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((c) => DropdownMenuItem(
                          value: c,
                          child: Text(c),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _category = v ?? _category),
              ),
              const SizedBox(height: 12),

              Text('Durasi: ${_duration.toInt()} jam'),
              Slider(
                min: 1,
                max: 8,
                divisions: 7,
                value: _duration,
                label: '${_duration.toInt()} jam',
                onChanged: (v) => setState(() => _duration = v),
              ),

              SwitchListTile(
                title: const Text('Sudah Selesai'),
                value: _done,
                onChanged: (v) => setState(() => _done = v),
              ),

              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Catatan Tambahan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
