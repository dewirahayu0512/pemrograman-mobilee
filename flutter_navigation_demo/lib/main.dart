import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const FlutterNavigationDemo());
}

class FlutterNavigationDemo extends StatelessWidget {
  const FlutterNavigationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
