import 'package:flutter/material.dart';
import 'second_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Biodata
  final String nama = "Dewi Rahayu";
  final String nim = "701230015";
  final String kelas = "5B";
  final String prodi = "Sistem Informasi";
  final String alamat = "Muaro Jambi";
  final String hobi = "Memasak dan Travelling";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE),
      appBar: AppBar(
        title: const Text('Halaman Utama'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Card profil
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'profile-photo',
                        child: CircleAvatar(
                          radius: 44,
                          backgroundImage:
                              const AssetImage('assets/images/profile.jpg'),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nama,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text('NIM: $nim'),
                            const SizedBox(height: 4),
                            Text(prodi),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Card Ringkasan (tengah, sesuai teks)
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 16),
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ringkasan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Kelas
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 90,
                                child: Text(
                                  'Kelas',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Text(" : "),
                              Text(kelas),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Alamat
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 90,
                                child: Text(
                                  'Alamat',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Text(" : "),
                              Text(alamat),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Hobi
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 90,
                                child: Text(
                                  'Hobi',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Text(" : "),
                              Text(hobi),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Tombol lihat detail
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    'Lihat Detail',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondPage(
                          nama: nama,
                          nim: nim,
                          kelas: kelas,
                          prodi: prodi,
                          alamat: alamat,
                          hobi: hobi,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
