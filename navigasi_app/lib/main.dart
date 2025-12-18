import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const NavigasiApp());
}

class NavigasiApp extends StatelessWidget {
  const NavigasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData.light();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'navigasi_app',
      theme: base.copyWith(
        colorScheme: base.colorScheme.copyWith(
          primary: const Color(0xFFEC407A), // pink lembut
          secondary: const Color(0xFFFFCDD2),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEC407A),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEC407A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
