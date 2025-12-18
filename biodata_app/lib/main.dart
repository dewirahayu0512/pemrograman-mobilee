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
        appBar: AppBar(
          title: const Text("Biodata App"),
          backgroundColor: Colors.pink,
        ),
        body: Container(
          width: double.infinity,
          color: Colors.pink[100], // latar belakang pink muda
          padding: const EdgeInsets.all(20),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,   // di tengah vertikal
              crossAxisAlignment: CrossAxisAlignment.center, // di tengah horizontal
              children: [
                Text(
                  "Nama: Dewi Rahayu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "NIM: 701230015",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Hobi: Memasak dan Travelling",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
