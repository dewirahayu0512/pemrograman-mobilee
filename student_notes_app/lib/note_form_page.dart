import 'package:flutter/material.dart';
import 'note.dart';

class NoteFormPage extends StatefulWidget {
  final Note? existingNote;
  const NoteFormPage({super.key, this.existingNote});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleC;
  late TextEditingController contentC;
  String category = "Kuliah";

  final categories = ["Kuliah", "Organisasi", "Pribadi", "Lain-lain"];

  @override
  void initState() {
    super.initState();
    titleC = TextEditingController(text: widget.existingNote?.title ?? "");
    contentC = TextEditingController(text: widget.existingNote?.content ?? "");
    category = widget.existingNote?.category ?? "Kuliah";
  }

  void save() {
    if (!_formKey.currentState!.validate()) return;

    final note = Note(
      title: titleC.text.trim(),
      content: contentC.text.trim(),
      category: category,
      createdAt: widget.existingNote?.createdAt ?? DateTime.now(),
    );

    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.existingNote == null ? "Catatan Baru" : "Edit Catatan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleC,
                decoration: const InputDecoration(labelText: "Judul", border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? "Judul wajib diisi" : null,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: category,
                items: categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => category = v!),
                decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Kategori"),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: TextFormField(
                  controller: contentC,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Isi Catatan",
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (v) => v!.isEmpty ? "Isi tidak boleh kosong" : null,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: save,
                  icon: const Icon(Icons.save),
                  label: const Text("Simpan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
