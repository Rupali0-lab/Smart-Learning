import 'package:flutter/material.dart';
import 'package:module1/common/cute_background.dart';
import 'gamification_data.dart';

class GamificationHome extends StatefulWidget {
  const GamificationHome({super.key});

  @override
  State<GamificationHome> createState() => _GamificationHomeState();
}

class _GamificationHomeState extends State<GamificationHome> {
  void earnPoints() {
    setState(() {
      GamificationData.addPoints(20);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✨ You earned 20 points!")),
    );
  }

  void increaseStreak() {
    setState(() {
      GamificationData.increaseStreak();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("🔥 Study streak increased! +15 bonus XP")),
    );
  }

  @override
  Widget build(BuildContext context) {
    double levelProgress = (GamificationData.points % 50) / 50;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rewards & Progress 🎮"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: CuteBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ⭐ Points
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.stars, color: Colors.orange),
                    title: const Text("Total Points"),
                    subtitle: Text("${GamificationData.points} XP"),
                  ),
                ),

                const SizedBox(height: 10),

                // 🎯 Level
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.trending_up, color: Colors.green),
                    title: const Text("Level"),
                    subtitle: Text("Level ${GamificationData.level}"),
                  ),
                ),

                const SizedBox(height: 8),

                // 📈 Progress Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Progress to Next Level",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: levelProgress,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${GamificationData.points % 50} / 50 XP",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 🔥 Streak
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.local_fire_department, color: Colors.red),
                    title: const Text("Study Streak"),
                    subtitle: Text("${GamificationData.streak} Days 🔥"),
                  ),
                ),

                const SizedBox(height: 10),

                // 🏅 Badge
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.emoji_events, color: Colors.amber),
                    title: const Text("Current Badge"),
                    subtitle: Text(GamificationData.getBadge()),
                  ),
                ),

                const SizedBox(height: 20),

                // 🐾 Virtual Pet
                const Text(
                  "Your Study Pet",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  GamificationData.getPetStage(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 40),
                ),

                const SizedBox(height: 20),

                // 🎁 Earn Points
                ElevatedButton.icon(
                  onPressed: earnPoints,
                  icon: const Icon(Icons.add),
                  label: const Text("Complete Study Task (+20 XP)"),
                ),

                const SizedBox(height: 10),

                // 🔥 Increase Streak
                ElevatedButton.icon(
                  onPressed: increaseStreak,
                  icon: const Icon(Icons.local_fire_department),
                  label: const Text("Study Today (Increase Streak)"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
