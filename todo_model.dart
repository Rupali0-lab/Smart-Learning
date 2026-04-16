class TodoTask {
  String title;
  String description;
  bool isDone;
  DateTime? reminderTime; // ✅ add this

  TodoTask({
    required this.title,
    required this.description,
    this.isDone = false,
    this.reminderTime, // ✅ add this
  });
}
