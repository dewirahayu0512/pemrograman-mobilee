import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com/posts';

  // GET DATA DARI API
  static Future<List<dynamic>> fetchTips() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal mengambil data dari API');
    }
  }
}
