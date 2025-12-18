import 'package:flutter/material.dart';
import '../models/feedback_item.dart';

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _commentCtrl = TextEditingController();
  String _gender = "L";
  double _rating = 3;
  bool _agree = false;

  final Map<String, bool> _hobbyMap = {
    "Coding": false,
    "Membaca": false,
    "Olahraga": false,
  };

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final hobbies =
        _hobbyMap.entries.where((e) => e.value).map((e) => e.key).toList();

    if (!_agree) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Perlu Persetujuan"),
          content: const Text(
              "Centang \"Setuju syarat & ketentuan\" untuk melanjutkan."),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"))
          ],
        ),
      );
      return;
    }

    final item = FeedbackItem(
      name: _nameCtrl.text.trim(),
      gender: _gender,
      rating: _rating,
      isAgree: _agree,
      hobbies: hobbies,
      comment: _commentCtrl.text.trim(),
    );

    Navigator.pop(context, item);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Feedback Pengguna")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? "Nama wajib diisi" : null,
            ),
            const SizedBox(height: 16),
            const Text("Jenis Kelamin",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    value: "L",
                    groupValue: _gender,
                    title: const Text("Laki-laki"),
                    onChanged: (v) => setState(() => _gender = v ?? "L"),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    value: "P",
                    groupValue: _gender,
                    title: const Text("Perempuan"),
                    onChanged: (v) => setState(() => _gender = v ?? "P"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text("Hobi",
                style: TextStyle(fontWeight: FontWeight.bold)),
            ..._hobbyMap.keys.map((h) {
              return CheckboxListTile(
                value: _hobbyMap[h],
                title: Text(h),
                onChanged: (val) =>
                    setState(() => _hobbyMap[h] = val ?? false),
              );
            }),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Rating (1–5)"),
                Text(_rating.toStringAsFixed(1)),
              ],
            ),
            Slider(
              min: 1,
              max: 5,
              divisions: 8,
              value: _rating,
              onChanged: (v) => setState(() => _rating = v),
            ),
            TextFormField(
              controller: _commentCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Komentar",
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SwitchListTile(
              value: _agree,
              title: const Text("Setuju syarat & ketentuan"),
              onChanged: (v) => setState(() => _agree = v),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              icon: const Icon(Icons.save),
              onPressed: _submit,
              label: const Text("Simpan & Kembalikan ke Home"),
            ),
          ],
        ),
      ),
    );
  }
}
