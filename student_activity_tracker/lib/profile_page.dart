import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDark;

  const ProfilePage({
    super.key,
    required this.onThemeChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 12),

            const Text(
              'Dewi Rahayu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            const Text(
              'Prodi: Sistem Informasi - UIN STS Jambi',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dark Mode", style: TextStyle(fontSize: 16)),
                Switch(value: isDark, onChanged: onThemeChanged),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Catatan: Project ini dibuat untuk UTS Pemrograman Perangkat Bergerak (Flutter).",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
