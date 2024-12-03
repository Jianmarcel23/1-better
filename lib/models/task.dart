class Task {
  String id;
  String title;
  String description;
  int targetDurationMinutes;
  DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.targetDurationMinutes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
