import 'package:flutter/material.dart';
import 'package:module1/login_module/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Study Smart App",

      theme: ThemeData(
        useMaterial3: true,

        // UI
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFBFA2FF), // lavender
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFFFFBFF), // off-white soft
        // ✅ AppBar style
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFE8F3), // soft pink
          foregroundColor: Color(0xFF2C2C2C),
          centerTitle: true,
          elevation: 0,
        ),

        // ✅ Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBFA2FF), // lavender
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFBFA2FF),
          foregroundColor: Colors.white,
        ),

        // ✅ Input field theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFF1F8), // very light pink
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xFFBFA2FF), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF444444)),
        ),

        // ✅ Checkbox Theme (for To-Do module)
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          fillColor: WidgetStateProperty.all(const Color(0xFFBFA2FF)),
        ),
      ),

      home: const LoginScreen(),
    );
  }
}
