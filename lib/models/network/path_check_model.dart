class PathCheck {
  const PathCheck({required this.id, required this.correct});

  final String id;
  final bool correct;

  factory PathCheck.fromJson(Map<String, dynamic> json) {
    return PathCheck(
      id: json['id'] as String,
      correct: json['correct'] as bool,
    );
  }
}
