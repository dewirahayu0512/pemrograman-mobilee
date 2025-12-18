import 'package:flutter/material.dart';
import 'model/activity_model.dart';

class ActivityDetailPage extends StatelessWidget {
  final Activity activity;
  const ActivityDetailPage({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Aktivitas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(activity.name, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Chip(label: Text(activity.category)),
          const SizedBox(height: 8),
          Row(children: [const Icon(Icons.timer), const SizedBox(width: 8), Text('${activity.duration} jam'), const SizedBox(width: 16), const Icon(Icons.check_circle_outline), const SizedBox(width: 8), Text(activity.done ? 'Selesai' : 'Belum selesai')]),
          const SizedBox(height: 12),
          const Text('Catatan tambahan', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(activity.notes.isEmpty ? '-' : activity.notes),
          const Spacer(),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text('Kembali'))),
            const SizedBox(width: 12),
            Expanded(child: ElevatedButton(onPressed: () async {
              final confirm = await showDialog<bool>(context: context, builder: (_) => AlertDialog(title: const Text('Konfirmasi Hapus'), content: const Text('Yakin ingin menghapus aktivitas ini?'), actions: [TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')), TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus'))]));
              if (confirm == true) Navigator.pop(context, 'deleted');
            }, child: const Text('Hapus Aktivitas')))
          ])
        ]),
      ),
    );
  }
}
