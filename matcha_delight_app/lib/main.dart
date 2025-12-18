import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/comment.dart';
import 'providers/product_provider.dart';
import 'providers/comment_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_edit_product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox<Comment>('comments');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ✅ Produk (static / katalog)
        ChangeNotifierProvider(
          create: (_) => ProductProvider()..loadData(),
        ),

        // ✅ Komentar (CRUD + HIVE)
        ChangeNotifierProvider(
          create: (_) => CommentProvider()..loadData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Matcha Catalog',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          '/': (context) => const HomeScreen(),
          '/add': (context) =>
              const AddEditProductScreen(category: 'Minuman'),
        },
      ),
    );
  }
}
