import 'package:flutter/material.dart';
import 'model/activity_model.dart';
import 'activity_detail_page.dart';
import 'add_activity_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final List<Activity> activities;
  final Function(List<Activity>) onUpdated;
  final Function(String) onDelete;

  const HomePage({
    super.key,
    required this.activities,
    required this.onUpdated,
    required this.onDelete,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Activity> _activities;

  @override
  void initState() {
    super.initState();
    _activities = List.from(widget.activities);
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList('activities') ?? [];

    setState(() {
      _activities = raw.map((s) => Activity.fromJson(s)).toList();
    });

    widget.onUpdated(_activities);
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = _activities.map((a) => a.toJson()).toList();

    await prefs.setStringList('activities', raw);
    widget.onUpdated(_activities);
  }

  void _deleteActivity(String id) async {
    final idx = _activities.indexWhere((a) => a.id == id);
    if (idx == -1) return;

    setState(() => _activities.removeAt(idx));
    await _saveToPrefs();
    widget.onDelete(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aktivitas dihapus')),
    );
  }

  void _openSearch() async {
    final result = await showSearch<Activity?>(
      context: context,
      delegate: ActivitySearchDelegate(_activities),
    );

    if (result != null) {
      final res = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ActivityDetailPage(activity: result)),
      );

      if (res == 'deleted') {
        _deleteActivity(result.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Activity Tracker'),
        actions: [
          IconButton(
            onPressed: _openSearch,
            icon: const Icon(Icons.search),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Daftar Aktivitas'),
                subtitle: Text('${_activities.length} item'),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: _activities.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.event_note_outlined, size: 64),
                          SizedBox(height: 8),
                          Text('Belum ada aktivitas.'),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _activities.length,
                      itemBuilder: (context, index) {
                        final a = _activities[index];

                        return Card(
                          child: ListTile(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ActivityDetailPage(activity: a),
                                ),
                              );

                              if (result == 'deleted') {
                                _deleteActivity(a.id);
                              }
                            },
                            title: Text(a.name),
                            subtitle:
                                Text('${a.category} • ${a.duration} jam'),
                            trailing: Icon(
                              a.done
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: a.done ? Colors.green : null,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newActivity = await Navigator.push<Activity>(
            context,
            MaterialPageRoute(builder: (_) => const AddActivityPage()),
          );

          if (newActivity != null) {
            setState(() => _activities.add(newActivity));
            await _saveToPrefs();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Aktivitas ditambahkan')),
            );

            widget.onUpdated(_activities);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ActivitySearchDelegate extends SearchDelegate<Activity?> {
  final List<Activity> list;
  ActivitySearchDelegate(this.list);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = list
        .where((a) =>
            a.name.toLowerCase().contains(query.toLowerCase()) ||
            a.category.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final a = results[index];

        return ListTile(
          title: Text(a.name),
          subtitle: Text('${a.category} • ${a.duration} jam'),
          onTap: () => close(context, a),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = list
        .where((a) =>
            a.name.toLowerCase().contains(query.toLowerCase()) ||
            a.category.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final a = suggestions[index];

        return ListTile(
          title: Text(a.name),
          subtitle: Text(a.category),
          onTap: () {
            query = a.name;
            showResults(context);
          },
        );
      },
    );
  }
}
