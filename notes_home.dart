import 'package:flutter/material.dart';
import 'package:module1/common/cute_background.dart';
import 'package:module1/login_module/login_screen.dart';
import 'package:module1/todo_module/todo_home.dart';
import 'package:module1/gamification_module/gamification_home.dart';
import 'package:module1/analytics_module/analytics_home.dart';
import 'package:module1/quiz_generator/quiz_home.dart';

import 'add_note.dart';
import 'edit_note.dart';
import 'note_model.dart';

class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  List<Note> notes = [];

  void addNewNote(Note note) {
    setState(() => notes.add(note));
  }

  void deleteNote(int index) {
    setState(() => notes.removeAt(index));
  }

  void updateNote(int index, Note updatedNote) {
    setState(() => notes[index] = updatedNote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // ================= DRAWER =================
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.deepPurple, Colors.purpleAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Profile Picture
      const CircleAvatar(
        radius: 35,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.person,
          size: 40,
          color: Colors.deepPurple,
        ),
      ),

      const SizedBox(height: 12),

      // User Name
      const Text(
        "Jereena", // you can later make this dynamic
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 4),

      // Email / subtitle
      const Text(
        "Student • Study Mode ON 📚",
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
    ],
  ),
),


            ListTile(
              leading: const Icon(Icons.note),
              title: const Text("My Notes"),
              onTap: () => Navigator.pop(context),
            ),

            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text("To-Do List"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const TodoHome()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text("Rewards & Progress"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const GamificationHome()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text("Analytics Dashboard"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const AnalyticsHome(tasksCompleted: 0, totalTasks: 0),
                  ),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      // ================= ADD NOTE BUTTON =================
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNotePage()),
          );

          if (newNote != null) addNewNote(newNote);
        },
        child: const Icon(Icons.add),
      ),

      // ================= BODY =================
      body: CuteBackground(
        child: notes.isEmpty
            ? const Center(
                child: Text(
                  "No notes yet!\nClick + to add a note.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              )
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        notes[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        notes[index].content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // ✏️ EDIT NOTE
                      onTap: () async {
                        final updated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                EditNotePage(note: notes[index]),
                          ),
                        );
                        if (updated != null) updateNote(index, updated);
                      },

                      // 🧠 QUIZ + 🗑 DELETE
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // AI Quiz Button
                          IconButton(
                            icon: const Icon(Icons.quiz,
                                color: Colors.deepPurple),
                            tooltip: "Generate AI Quiz",
                            onPressed: () {
                              final noteText = notes[index].content.trim();

                              if (noteText.length < 20) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Note content too small to generate quiz 😅"),
                                  ),
                                );
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      QuizHome(notesText: noteText),
                                ),
                              );
                            },
                          ),

                          // Delete Button
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: "Delete Note",
                            onPressed: () => deleteNote(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
