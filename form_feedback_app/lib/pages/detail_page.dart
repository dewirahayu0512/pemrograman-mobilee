import 'package:flutter/material.dart';
import '../models/feedback_item.dart';

class DetailPage extends StatelessWidget {
  final FeedbackItem item;
  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Feedback")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Nama"),
            subtitle: Text(item.name),
          ),
          ListTile(
            leading: const Icon(Icons.transgender),
            title: const Text("Jenis Kelamin"),
            subtitle: Text(item.gender == "L" ? "Laki-laki" : "Perempuan"),
          ),
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: const Text("Rating"),
            subtitle: Text(item.rating.toStringAsFixed(1)),
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text("Hobi"),
            subtitle:
                Text(item.hobbies.isEmpty ? "-" : item.hobbies.join(", ")),
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text("Komentar"),
            subtitle: Text(item.comment.isEmpty ? "-" : item.comment),
          ),
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text("Kembali"),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
