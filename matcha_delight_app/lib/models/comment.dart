import 'package:hive/hive.dart';

part 'comment.g.dart';

@HiveType(typeId: 1)
class Comment extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String productId;

  @HiveField(2)
  String name;

  @HiveField(3)
  String message;

  @HiveField(4)
  int rating;

  Comment({
    required this.id,
    required this.productId,
    required this.name,
    required this.message,
    required this.rating,
  });
}
