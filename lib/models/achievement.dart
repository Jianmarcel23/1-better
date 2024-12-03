class Achievement {
  final String id;
  final String title;
  final String description;
  final int requiredTasksCompleted;
  bool isUnlocked;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.requiredTasksCompleted,
    this.isUnlocked = false,
  });

  static List<Achievement> defaultAchievements = [
    Achievement(
      id: 'starter',
      title: 'Pemula Produktif',
      description: 'Selesaikan 5 tugas pertamamu',
      requiredTasksCompleted: 5,
    ),
    Achievement(
      id: 'consistent',
      title: 'Konsisten Champion',
      description: 'Selesaikan 20 tugas berturut-turut',
      requiredTasksCompleted: 20,
    ),
    Achievement(
      id: 'marathon',
      title: 'Produktivitas Marathon',
      description: 'Habiskan 50 jam produktif',
      requiredTasksCompleted: 50,
    ),
  ];
}
