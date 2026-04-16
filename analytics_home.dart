import 'package:flutter/material.dart';
import 'package:module1/common/cute_background.dart';
import 'package:module1/gamification_module/gamification_data.dart';
import 'analytics_model.dart';

class AnalyticsHome extends StatelessWidget {
  final int tasksCompleted;
  final int totalTasks;

  const AnalyticsHome({
    super.key,
    required this.tasksCompleted,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    final AnalyticsData data = AnalyticsData(
      totalXP: GamificationData.points,
      tasksCompleted: tasksCompleted,
      totalTasks: totalTasks,
      studyStreak: GamificationData.streak,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics & Insights 📊"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CuteBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildStatCard("Total XP", data.totalXP.toString(), Icons.star),
              _buildStatCard("Tasks Completed",
                  "${data.tasksCompleted}/${data.totalTasks}", Icons.check_circle),
              _buildStatCard(
                  "Task Completion Rate",
                  "${data.taskCompletionRate.toStringAsFixed(1)}%",
                  Icons.show_chart),
              _buildStatCard("Study Streak",
                  "${data.studyStreak} days", Icons.local_fire_department),
              const SizedBox(height: 20),
              _buildInsightsCard(data),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.deepPurple),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildInsightsCard(AnalyticsData data) {
    String insight;

    if (data.taskCompletionRate >= 80) {
      insight = "Amazing consistency! You're staying on top of your tasks 💪";
    } else if (data.taskCompletionRate >= 40) {
      insight = "Good progress! Try completing tasks on time ⏳";
    } else {
      insight = "Let’s improve task consistency. Small steps daily help 📅";
    }

    return Card(
      color: Colors.deepPurple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Insights 💡",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(insight, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
