import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/comment.dart';

class CommentProvider with ChangeNotifier {
  late Box<Comment> _commentBox;

  List<Comment> get _comments => _commentBox.values.toList();

  // 🔑 WAJIB DIPANGGIL DI main.dart
  Future<void> loadData() async {
    _commentBox = Hive.box<Comment>('comments');
    notifyListeners();
  }

  List<Comment> byProduct(String productId) {
    return _comments.where((c) => c.productId == productId).toList();
  }

  // ➕ CREATE
  void add(Comment c) {
    _commentBox.put(c.id, c);
    notifyListeners();
  }

  // ✏️ UPDATE
  void update(String id, Comment c) {
    _commentBox.put(id, c);
    notifyListeners();
  }

  // 🗑️ DELETE
  void delete(String id) {
    _commentBox.delete(id);
    notifyListeners();
  }
}
