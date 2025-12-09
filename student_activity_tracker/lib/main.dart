import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'add_activity_page.dart';
import 'profile_page.dart';
import 'model/activity_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkMode') ?? false;

  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatefulWidget {
  final bool isDark;

  const MyApp({super.key, required this.isDark});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDark;
  }

  void _toggleTheme(bool value) async {
    setState(() => _isDark = value);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Activity Tracker',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,

      home: RootPage(
        isDark: _isDark,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  final bool isDark;
  final Function(bool) onThemeChanged;

  const RootPage({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _index = 0;
  List<Activity> _activities = [];

  void _setActivities(List<Activity> newList) {
    setState(() => _activities = newList);
  }

  void _addActivity(Activity a) {
    setState(() => _activities.add(a));
  }

  void _removeActivity(String id) {
    setState(() => _activities.removeWhere((x) => x.id == id));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        activities: _activities,
        onUpdated: _setActivities,
        onDelete: _removeActivity,
      ),
      AddActivityPage(onAdd: _addActivity),
      ProfilePage(
        isDark: widget.isDark,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    return Scaffold(
      body: pages[_index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
