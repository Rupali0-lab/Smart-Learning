class AnalyticsData {
  int totalXP;
  int tasksCompleted;
  int totalTasks;
  int studyStreak;

  AnalyticsData({
    required this.totalXP,
    required this.tasksCompleted,
    required this.totalTasks,
    required this.studyStreak,
  });

  double get taskCompletionRate =>
      totalTasks == 0 ? 0 : (tasksCompleted / totalTasks) * 100;
}
