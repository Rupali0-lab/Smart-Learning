import 'dart:async';
import 'package:flutter/material.dart';

class ReminderService {
  static void scheduleReminder(
      BuildContext context, String title, DateTime time) {

    Duration delay = time.difference(DateTime.now());

    print("⏰ Reminder set for: $time");
    print("⏳ Delay seconds: ${delay.inSeconds}");

    if (delay.isNegative) return;

    Timer(delay, () {
      print("🚨 Reminder triggered!");

      if (!context.mounted) {
        print("❌ Context not mounted");
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Study Reminder ⏰"),
          content: Text("Time to do: $title"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    });
  }
}
