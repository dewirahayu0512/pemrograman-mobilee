class FeedbackItem {
  final String name;
  final String gender; // "L" / "P"
  final double rating; // 1..5
  final bool isAgree;
  final List<String> hobbies;
  final String comment;

  FeedbackItem({
    required this.name,
    required this.gender,
    required this.rating,
    required this.isAgree,
    required this.hobbies,
    required this.comment,
  });
}
