import 'package:flutter/material.dart';
import 'detail_page.dart';

class Dosen {
  final String nama;
  final String nip;
  final String email;
  final String foto;
  final String keahlian;

  const Dosen({
    required this.nama,
    required this.nip,
    required this.email,
    required this.foto,
    required this.keahlian,
  });
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Dosen> daftarDosen = const [
    Dosen(
      nama: 'Choi Seung-Cheol, M.Kom',
      nip: '19700115 200201 1 004',
      keahlian: 'Kepemimpinan',
      foto: 'assets/images/scoups.jpg',
      email: 'scoups@univ.ac.id',
    ),
    Dosen(
      nama: 'Yoon Jeong-Han, M.Pd',
      nip: '19891004 201003 1 005',
      keahlian: 'Psikologi Pendidikan',
      foto: 'assets/images/jeonghan.jpg',
      email: 'jeonghan@univ.ac.id',
    ),
    Dosen(
      nama: 'Hong Ji-Soo, M.T',
      nip: '19850215 201004 2 006',
      keahlian: 'Desain dan Estetika',
      foto: 'assets/images/joshua.jpg',
      email: 'joshua@univ.ac.id',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Dosen'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftarDosen.length,
        itemBuilder: (context, index) {
          final dosen = daftarDosen[index];
          return Card(
            color: Colors.pink.shade50,
            shadowColor: Colors.pinkAccent,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(dosen.foto),
              ),
              title: Text(
                dosen.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              subtitle: Text(
                dosen.keahlian,
                style: TextStyle(color: Colors.pink.shade400),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.pink),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(dosen: dosen),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
