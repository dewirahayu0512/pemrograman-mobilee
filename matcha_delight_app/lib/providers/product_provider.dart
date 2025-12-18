import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> byCategory(String category) =>
      _products.where((p) => p.category == category).toList();

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('products');

    if (data != null) {
      _products =
          (json.decode(data) as List).map((e) => Product.fromJson(e)).toList();
    } else {
      _products = [
        // ================== MINUMAN ==================
        Product(
          id: '1',
          name: 'Matcha Latte',
          category: 'Minuman',
          price: 28000,
          image: 'assets/images/matcha_latte.jpg',
          description:
              'Matcha Latte dibuat dari bubuk matcha premium pilihan yang diseduh dengan air hangat, kemudian dipadukan dengan susu segar berkualitas. Menghasilkan rasa creamy yang lembut, aroma matcha yang khas, serta sensasi menenangkan di setiap tegukan. Cocok dinikmati saat santai maupun menemani aktivitas harian.',
        ),
        Product(
          id: '2',
          name: 'Matcha Frappe',
          category: 'Minuman',
          price: 40000,
          image: 'assets/images/matcha_frappe.jpg',
          description:
              'Matcha Frappe merupakan minuman dingin berbasis matcha dengan tekstur lembut dan menyegarkan. Perpaduan es, susu, dan matcha menghasilkan rasa manis seimbang serta sensasi dingin yang cocok dinikmati di cuaca panas.',
        ),
        Product(
          id: '3',
          name: 'Matcha Americano',
          category: 'Minuman',
          price: 22000,
          image: 'assets/images/matcha_americano.jpg',
          description:
              'Matcha Americano adalah sajian matcha murni tanpa tambahan susu, menghadirkan rasa autentik dan aroma alami teh hijau Jepang. Cocok untuk pecinta matcha sejati yang menginginkan rasa ringan namun tetap kuat.',
        ),
        Product(
          id: '4',
          name: 'Matcha Milk',
          category: 'Minuman',
          price: 30000,
          image: 'assets/images/matcha_milk.jpg',
          description:
              'Matcha Milk memadukan matcha berkualitas dengan susu segar, menciptakan rasa lembut, manis alami, dan menenangkan. Minuman ini cocok untuk semua kalangan dan bisa dinikmati kapan saja.',
        ),
        Product(
          id: '5',
          name: 'Matcha Float',
          category: 'Minuman',
          price: 38000,
          image: 'assets/images/matcha_float.jpg',
          description:
              'Matcha Float adalah kombinasi matcha dingin dengan tambahan es krim vanilla di atasnya. Perpaduan pahit lembut matcha dan manisnya es krim menciptakan sensasi rasa yang unik dan menyenangkan.',
        ),
        Product(
          id: '6',
          name: 'Matcha Lemon',
          category: 'Minuman',
          price: 29000,
          image: 'assets/images/matcha_lemon.jpg',
          description:
              'Matcha Lemon menawarkan sensasi segar dari perpaduan matcha dan perasan lemon alami. Rasa asam segar yang ringan berpadu dengan aroma matcha, cocok untuk menyegarkan tubuh.',
        ),
        Product(
          id: '7',
          name: 'Matcha Soda',
          category: 'Minuman',
          price: 26000,
          image: 'assets/images/matcha_soda.jpg',
          description:
              'Matcha Soda merupakan minuman berkarbonasi dengan cita rasa matcha yang unik. Sensasi soda yang menyegarkan berpadu dengan aroma teh hijau, memberikan pengalaman minum yang berbeda.',
        ),
        Product(
          id: '8',
          name: 'Matcha Caramel',
          category: 'Minuman',
          price: 30000,
          image: 'assets/images/matcha_caramel.jpg',
          description:
              'Matcha Caramel menghadirkan perpaduan matcha lembut dengan saus caramel manis. Rasa pahit manis yang seimbang menjadikannya favorit bagi pencinta minuman manis.',
        ),
        Product(
          id: '9',
          name: 'Matcha Hazelnut',
          category: 'Minuman',
          price: 30000,
          image: 'assets/images/matcha_hazelnut.jpg',
          description:
              'Matcha Hazelnut menggabungkan aroma kacang hazelnut yang khas dengan matcha premium. Memberikan rasa gurih, lembut, dan aroma yang menggoda.',
        ),
        Product(
          id: '10',
          name: 'Matcha Vanilla',
          category: 'Minuman',
          price: 33000,
          image: 'assets/images/matcha_vanilla.jpg',
          description:
              'Matcha Vanilla menawarkan rasa lembut dengan sentuhan vanilla yang manis dan harum. Cocok bagi penikmat minuman matcha dengan cita rasa ringan.',
        ),

        // ================== DESSERT ==================
        Product(
          id: '11',
          name: 'Matcha Cake',
          category: 'Dessert',
          price: 32000,
          image: 'assets/images/matcha_cake.jpg',
          description:
              'Matcha Cake dibuat dari adonan lembut dengan bubuk matcha berkualitas. Teksturnya empuk, rasa manisnya pas, dan aroma matcha terasa kuat di setiap gigitan.',
        ),
        Product(
          id: '12',
          name: 'Matcha Cheesecake',
          category: 'Dessert',
          price: 37000,
          image: 'assets/images/matcha_cheesecake.jpg',
          description:
              'Matcha Cheesecake memadukan keju creamy dengan matcha premium. Rasa gurih keju berpadu dengan pahit lembut matcha menciptakan dessert yang elegan.',
        ),
        Product(
          id: '13',
          name: 'Matcha Brownies',
          category: 'Dessert',
          price: 28000,
          image: 'assets/images/matcha_brownies.jpg',
          description:
              'Matcha Brownies memiliki tekstur padat namun lembut dengan rasa cokelat dan matcha yang seimbang. Cocok sebagai camilan manis.',
        ),
        Product(
          id: '14',
          name: 'Matcha Tiramisu',
          category: 'Dessert',
          price: 40000,
          image: 'assets/images/matcha_tiramisu.jpg',
          description:
              'Matcha Tiramisu adalah dessert berlapis dengan krim lembut dan rasa matcha yang khas. Memberikan sensasi manis, lembut, dan elegan.',
        ),
        Product(
          id: '15',
          name: 'Matcha Roll Cake',
          category: 'Dessert',
          price: 36000,
          image: 'assets/images/matcha_rollcake.jpg',
          description:
              'Matcha Roll Cake memiliki tekstur sponge yang ringan dengan isian krim matcha lembut. Cocok dinikmati sebagai teman minum teh.',
        ),
        Product(
          id: '16',
          name: 'Matcha Mochi',
          category: 'Dessert',
          price: 19000,
          image: 'assets/images/matcha_mochi.jpg',
          description:
              'Matcha Mochi bertekstur kenyal dengan isian lembut rasa matcha. Dessert khas Jepang ini cocok untuk camilan ringan.',
        ),
        Product(
          id: '17',
          name: 'Matcha Pudding',
          category: 'Dessert',
          price: 28000,
          image: 'assets/images/matcha_pudding.jpg',
          description:
              'Matcha Pudding memiliki tekstur lembut dan dingin dengan rasa matcha yang ringan. Cocok sebagai dessert penutup.',
        ),
        Product(
          id: '18',
          name: 'Matcha Donut',
          category: 'Dessert',
          price: 15000,
          image: 'assets/images/matcha_donut.jpg',
          description:
              'Matcha Donut dibuat dengan adonan empuk dan lapisan matcha manis di atasnya. Cocok untuk camilan kapan saja.',
        ),
        Product(
          id: '19',
          name: 'Matcha Cupcake',
          category: 'Dessert',
          price: 25000,
          image: 'assets/images/matcha_cupcake.jpg',
          description:
              'Matcha Cupcake memiliki ukuran pas dengan topping krim matcha lembut. Manisnya seimbang dan tampilan menarik.',
        ),
        Product(
          id: '20',
          name: 'Matcha Cookie',
          category: 'Dessert',
          price: 18000,
          image: 'assets/images/matcha_cookie.jpg',
          description:
              'Matcha Cookie bertekstur renyah dengan aroma matcha yang khas. Cocok sebagai camilan ringan.',
        ),
      ];
      saveData();
    }
    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'products',
      json.encode(_products.map((e) => e.toJson()).toList()),
    );
  }

  void add(Product p) {
    _products.add(p);
    saveData();
    notifyListeners();
  }

  void update(String id, Product p) {
    final i = _products.indexWhere((e) => e.id == id);
    _products[i] = p;
    saveData();
    notifyListeners();
  }

  void delete(String id) {
    _products.removeWhere((e) => e.id == id);
    saveData();
    notifyListeners();
  }
}
