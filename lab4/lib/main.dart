import 'package:flutter/material.dart';
import 'package:lab4/Exercise.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 UI Fundamentals',
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple
      ),
      home: const MainMenu(),
    );
  }
}

// --- TRANG MENU CHÍNH ---
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> exercises = [
      "Exercise 1 – Core Widgets Demo",
      "Exercise 2 – Input Controls Demo",
      "Exercise 3 – Layout Demo",
      "Exercise 4 – App Structure & Theme",
      "Exercise 5 – Common UI Fixes",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lab 4 – Flutter UI Fundament..."), // [cite: 18]
        elevation: 2,
      ),
      body: Container(
        color: const Color(0xFFF8F4FF), // Màu nền tím nhạt như trong ảnh
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(exercises[index]),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // LOGIC ĐIỀU HƯỚNG TẠI ĐÂY
                  Widget nextPage;
                  switch (index) {
                    case 0: nextPage = const CoreWidgetsDemo(); break;
                    case 1: nextPage = const InputControlsDemo(); break;
                    case 2: nextPage = const LayoutDemo(); break;
                    case 3: nextPage = const ThemeDemoApp(); break;
                    case 4: nextPage = const CommonUIFixes(); break;
                    default: nextPage = const MainMenu();
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}