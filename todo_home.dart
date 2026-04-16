import 'package:flutter/material.dart';
import 'package:module1/common/cute_background.dart';
import 'package:module1/gamification_module/gamification_data.dart';
import 'package:module1/notification_module/reminder_service.dart';
import 'package:module1/analytics_module/analytics_home.dart';
import 'todo_model.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final List<TodoTask> tasks = [];

  int completedTasks() => tasks.where((t) => t.isDone).length;

  // ================= ADD TASK WITH REMINDER =================
  void addTask() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    DateTime? selectedTime;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Add New Task with Reminder ⏰"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: "Task Title"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descController,
                      decoration: const InputDecoration(labelText: "Task Description"),
                    ),
                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      icon: const Icon(Icons.alarm),
                      label: const Text("Set Reminder Time"),
                      onPressed: () async {
                        DateTime now = DateTime.now();

                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: now,
                          lastDate: DateTime(2100),
                          initialDate: now,
                        );
                        if (pickedDate == null) return;

                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime == null) return;

                        setStateDialog(() {
                          selectedTime = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                      },
                    ),

                    if (selectedTime != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Reminder set for: $selectedTime",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    String title = titleController.text.trim();
                    String desc = descController.text.trim();

                    if (title.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Task title required ❗")),
                      );
                      return;
                    }

                    TodoTask newTask = TodoTask(
                      title: title,
                      description: desc,
                      reminderTime: selectedTime,
                    );

                    setState(() {
                      tasks.add(newTask);
                    });

                    if (selectedTime != null) {
                      ReminderService.scheduleReminder(
                        Navigator.of(context).context,
                        title,
                        selectedTime!,
                      );
                    }

                    Navigator.pop(context);
                  },
                  child: const Text("Add Task"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    int total = tasks.length;
    int completed = completedTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Study To-Do List 📝"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.school, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "Study App Modules",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Analytics & Insights"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnalyticsHome(
                      tasksCompleted: completedTasks(),
                      totalTasks: tasks.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),

      body: CuteBackground(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Completed: $completed / $total",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.favorite,
                        color: (total != 0 && completed == total)
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          "No tasks yet 🥹\nClick + to add your first task!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Checkbox(
                                value: tasks[index].isDone,
                                onChanged: (value) {
                                  setState(() {
                                    tasks[index].isDone = value!;
                                    if (value == true) {
                                      GamificationData.addPoints(10);
                                    }
                                  });
                                },
                              ),
                              title: Text(tasks[index].title),
                              subtitle: tasks[index].reminderTime != null
                                  ? Text("Reminder: ${tasks[index].reminderTime}")
                                  : null,
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteTask(index),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
