import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pink[50], // Warna latar belakang
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text("Aplikasi Biodata"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/DEWI.jpg'),
              ),
              const SizedBox(height: 15),

              // Nama
              const Text(
                "Dewi Rahayu",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // NIM
              const Text(
                "NIM: 701230015",
                style: TextStyle(fontSize: 16),
              ),

              // Prodi
              const Text(
                "Mahasiswa Sistem Informasi",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Email
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.pink),
                  SizedBox(width: 8),
                  Text("dewirahayu2778@gmail.com"),
                ],
              ),
              const SizedBox(height: 10),

              // Hobi
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: Colors.pink),
                  SizedBox(width: 8),
                  Text("Hobi: Memasak dan Travelling"),
                ],
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  print("Profil ditekan");
                },
                child: const Text("Lihat Profil"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
