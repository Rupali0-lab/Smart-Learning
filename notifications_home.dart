import 'package:flutter/material.dart';
import 'reminder_model.dart';

class NotificationsHome extends StatelessWidget {
  final List<Reminder> reminders = [
    Reminder(title: "Math Revision", time: DateTime.now().add(const Duration(hours: 2))),
    Reminder(title: "Science Quiz", time: DateTime.now().add(const Duration(days: 1))),
  ];

  NotificationsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders 🔔"),
        centerTitle: true,
      ),
      body: reminders.isEmpty
          ? const Center(child: Text("No reminders set yet 😊"))
          : ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.alarm),
                    title: Text(reminder.title),
                    subtitle: Text(reminder.time.toString()),
                  ),
                );
              },
            ),
    );
  }
}
