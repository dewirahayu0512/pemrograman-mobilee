import 'dart:convert';

class Activity {
  final String id;
  final String name;
  final String category;
  final int duration;
  final bool done;
  final String notes;

  Activity({
    required this.id,
    required this.name,
    required this.category,
    required this.duration,
    required this.done,
    required this.notes,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'category': category,
        'duration': duration,
        'done': done,
        'notes': notes,
      };

  factory Activity.fromMap(Map<String, dynamic> m) => Activity(
        id: m['id'],
        name: m['name'],
        category: m['category'],
        duration: (m['duration'] as num).toInt(),
        done: m['done'] == true || m['done'] == 1,
        notes: m['notes'] ?? '',
      );

  String toJson() => jsonEncode(toMap());

  factory Activity.fromJson(String s) => Activity.fromMap(jsonDecode(s));
}
