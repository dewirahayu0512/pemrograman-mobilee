import 'package:flutter/material.dart';
import '../models/feedback_item.dart';
import 'feedback_form_page.dart';
import 'counter_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<FeedbackItem> _items = [];

  Future<void> _openForm() async {
    final result = await Navigator.push<FeedbackItem>(
      context,
      MaterialPageRoute(builder: (_) => const FeedbackFormPage()),
    );

    if (result != null) {
      setState(() => _items.add(result));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback berhasil ditambahkan')),
      );
    }
  }

  void _openCounterDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CounterPage()),
    );
  }

  void _openDetail(FeedbackItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demo: State & Interaksi Pengguna")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.add_comment),
                    label: const Text("Tambah Feedback"),
                    onPressed: _openForm,
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.exposure_plus_1),
                  label: const Text("Counter Demo"),
                  onPressed: _openCounterDemo,
                ),
              ],
            ),
          ),
          const Divider(height: 16),
          Expanded(
            child: _items.isEmpty
                ? const Center(
                    child: Text(
                      "Belum ada data.\nTekan \"Tambah Feedback\" untuk mulai.",
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, i) {
                      final it = _items[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              it.name.isNotEmpty
                                  ? it.name[0].toUpperCase()
                                  : "?",
                            ),
                          ),
                          title: Text(it.name),
                          subtitle: Text(
                            "Gender: ${it.gender == 'L' ? 'Laki-laki' : 'Perempuan'}  •  "
                            "Rating: ${it.rating.toStringAsFixed(1)}  •  "
                            "Hobi: ${it.hobbies.join(', ')}",
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _openDetail(it),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openForm,
        icon: const Icon(Icons.add),
        label: const Text("Feedback"),
      ),
    );
  }
}
