import 'package:flutter/material.dart';
import 'local_storage.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDark = await LocalStorage.loadDarkMode();
  runApp(MyApp(initialDarkMode: isDark));
}

class MyApp extends StatefulWidget {
  final bool initialDarkMode;
  const MyApp({super.key, required this.initialDarkMode});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
    isDark = widget.initialDarkMode;
  }

  void toggleTheme(bool value) {
    setState(() => isDark = value);
    LocalStorage.saveDarkMode(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      home: HomePage(isDark: isDark, onThemeChanged: toggleTheme),
    );
  }
}
