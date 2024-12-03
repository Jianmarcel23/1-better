class TaskAnalytics {
  final int totalTasksCompleted;
  final Duration totalProductiveTime;
  final double productivityScore;
  final List<TaskPerformance> weeklyPerformance;

  TaskAnalytics({
    required this.totalTasksCompleted,
    required this.totalProductiveTime,
    required this.productivityScore,
    required this.weeklyPerformance,
  });
}

class TaskPerformance {
  final DateTime date;
  final int tasksCompleted;
  final Duration productiveTime;

  TaskPerformance({
    required this.date,
    required this.tasksCompleted,
    required this.productiveTime,
  });
}
