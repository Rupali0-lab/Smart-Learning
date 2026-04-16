class GamificationData {
  static int points = 0;
  static int level = 1;

  static void addPoints(int value) {
    points += value;
    level = (points ~/ 50) + 1; // every 50 pts = level up
  }

  static String getBadge() {
    if (points >= 300) return "🏆 Master Scholar";
    if (points >= 200) return "🥇 Gold Learner";
    if (points >= 100) return "🥈 Silver Learner";
    if (points >= 50) return "🥉 Bronze Learner";
    return "🌱 Beginner";
  }

  static String getPetStage() {
    if (points >= 300) return "🐉 Legendary Pet";
    if (points >= 200) return "🦄 Magic Pet";
    if (points >= 100) return "🐼 Happy Pet";
    if (points >= 50) return "🐣 Growing Pet";
    return "🥚 Baby Pet";
  }
  static int streak = 0;
  static void increaseStreak() {
    streak++;
    addPoints(15); // bonus for maintaining streak
  }

}
