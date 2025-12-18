import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  late Future<List<dynamic>> tipsFuture;

  @override
  void initState() {
    super.initState();
    tipsFuture = ApiService.fetchTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tips Matcha (API)'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: tipsFuture,
        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ERROR
          if (snapshot.hasError) {
            return const Center(
              child: Text('Terjadi kesalahan saat memuat data'),
            );
          }

          // DATA
          final data = snapshot.data!;

          return ListView.builder(
            itemCount: 10, // batasi biar rapi
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.eco, color: Colors.green),
                  title: Text(
                    data[index]['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data[index]['body']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
