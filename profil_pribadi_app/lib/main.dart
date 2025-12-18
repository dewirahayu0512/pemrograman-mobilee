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
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          title: const Text("Profil Pribadi"),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Foto Profil
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/images/DEWI.jpg"),
              ),
              const SizedBox(height: 15),

              // Nama
              const Text(
                "Dewi Rahayu",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Deskripsi
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Saya adalah mahasiswa aktif semester 5 Program Studi Sistem Informasi, Universitas Islam Negeri Sulthan Thaha Saifuddin Jambi.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),

              // Tombol SnackBar
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Selamat datang di profil Dewi Rahayu!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text("Lihat Profil"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
