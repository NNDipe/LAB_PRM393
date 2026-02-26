import 'package:flutter/material.dart';

// ==========================================
// EXERCISE 1: CORE WIDGETS [cite: 30]
// ==========================================
class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thanh tiêu đề có nút quay lại mặc định khi dùng Navigator.push [cite: 41, 75]
      appBar: AppBar(
        title: const Text("Exercise 1 – Core Widge..."), // Tên tiêu đề theo ảnh mẫu [cite: 41]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Căn giữa các widget theo chiều ngang [cite: 33]
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Headline Text [cite: 35, 42]
              const Text(
                "Welcome to Flutter UI",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // 2. Material Icon (Sử dụng icon movie/video giống ảnh mẫu)
              const Icon(
                Icons.movie_creation,
                color: Colors.blue,
                size: 100,
              ),
              const SizedBox(height: 20),

              // 3. Image.network (Hiển thị ảnh từ URL) [cite: 37]
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://picsum.photos/seed/picsum/400/250',
                  //height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // 4. Card containing a ListTile [cite: 38, 43, 44]
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const ListTile(
                  leading: Icon(Icons.star, color: Colors.black54), // Icon sao bên trái
                  title: Text(
                    "Movie Item",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "This is a sample ListTile inside a Card.",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// EXERCISE 2: INPUT WIDGETS [cite: 45]
// ==========================================
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});
  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _rating = 50.0; // [cite: 54]
  bool _isActive = false; // [cite: 56]
  String _genre = "None"; // [cite: 59]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 2-Input Controls")),
      body: ListView( // [cite: 46]
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Rating (Slider)", style: TextStyle(fontWeight: FontWeight.bold)), // [cite: 53]
          Text("Current value ${_rating.toInt()}"),
          Slider(value: _rating, min: 0, max: 100, onChanged: (v) => setState(() => _rating = v)), // [cite: 48]

          const SizedBox(height: 20),
          const Text("Active (Switch)", style: TextStyle(fontWeight: FontWeight.bold)),
          SwitchListTile(title: const Text("Is movie active?"), value: _isActive, onChanged: (v) => setState(() => _isActive = v)), // [cite: 48, 55]

          const SizedBox(height: 20),
          const Text("Genre (RadioListTile)", style: TextStyle(fontWeight: FontWeight.bold)), // [cite: 57]
          RadioListTile(title: const Text("Action"), value: "Action", groupValue: _genre, onChanged: (v) => setState(() => _genre = v!)), // [cite: 57]
          RadioListTile(title: const Text("Comedy"), value: "Comedy", groupValue: _genre, onChanged: (v) => setState(() => _genre = v!)), // [cite: 58]
          Text("Selected genre: $_genre"), // Hiển thị giá trị đã chọn

          const SizedBox(height: 30),
          ElevatedButton( // [cite: 49]
            onPressed: () => showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2030)),
            child: const Text("Open Date Picker"), // [cite: 60]
          ),
        ],
      ),
    );
  }
}

// ==========================================
// EXERCISE 3: LAYOUT BASICS [cite: 61]
// ==========================================
class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> movies = [
      {'title': 'Avatar', 'desc': 'Sample description'}, // [cite: 80]
      {'title': 'Inception', 'desc': 'Sample description'}, // [cite: 82]
      {'title': 'Interstellar', 'desc': 'Sample description'}, // [cite: 84]
      {'title': 'Joker', 'desc': 'Sample description'}, // [cite: 86]
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Exercise 3 – Layout De...")), // [cite: 78]
      body: Column( // [cite: 64]
        children: [
          const SizedBox(height: 20),
          const Text("Now Playing", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // [cite: 79]
          const SizedBox(height: 20),
          Expanded( // [cite: 66, 109]
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16), // [cite: 67]
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xFFF5F5F7),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar( // Hiển thị ký tự A, I, I, J
                      backgroundColor: const Color(0xFFE0E0FF),
                      child: Text(movies[index]['title']![0], style: const TextStyle(color: Colors.indigo)),
                    ),
                    title: Text(movies[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(movies[index]['desc']!), // [cite: 81]
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// EXERCISE 4: APP STRUCTURE & THEME [cite: 68]
// ==========================================
class ThemeDemoApp extends StatefulWidget {
  const ThemeDemoApp({super.key});
  @override
  State<ThemeDemoApp> createState() => _ThemeDemoAppState();
}

class _ThemeDemoAppState extends State<ThemeDemoApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    // Sử dụng Theme để bọc Scaffold thay vì MaterialApp mới [cite: 90, 110]
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold( // [cite: 70]
        appBar: AppBar(title: const Text("Exercise 4- App Structure")), // [cite: 72]
        body: Center(child: Text(_isDark ? "Dark Theme Active" : "Light Theme Active")), // [cite: 73]
        floatingActionButton: FloatingActionButton( // [cite: 74, 91]
          onPressed: () => setState(() => _isDark = !_isDark),
          child: const Icon(Icons.brightness_6),
        ),
      ),
    );
  }
}

// ==========================================
// EXERCISE 5: COMMON UI FIXES [cite: 92]
// ==========================================
class CommonUIFixes extends StatefulWidget {
  const CommonUIFixes({super.key});

  @override
  State<CommonUIFixes> createState() => _CommonUIFixesState();
}

class _CommonUIFixesState extends State<CommonUIFixes> {
  // Dữ liệu mẫu cho danh sách phim
  final List<String> _movies = ["Movie A", "Movie B", "Movie C", "Movie D"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 5 Common U..."), // [cite: 95]
      ),
      // Nhiệm vụ 2: Sử dụng SingleChildScrollView để tránh lỗi tràn (overflow)
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Correct ListView inside Column using Expanded", // [cite: 96]
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),

              // Nhiệm vụ 1: Fix ListView inside Column dùng SizedBox hoặc Expanded [cite: 98]
              // Lưu ý: Trong Column lồng trong SingleChildScrollView, phải dùng SizedBox có chiều cao cố định
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.movie), // Icon theo mẫu [cite: 95]
                      title: Text(_movies[index]), // [cite: 97, 99, 101, 103]
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Nhiệm vụ 3: Minh họa fix state update bằng setState()
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Nhiệm vụ 4: Gọi DatePicker từ context hợp lệ
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    );
                  },
                  child: const Text("Test DatePicker Context"),
                ),
              ),

              // Thêm khoảng trống lớn phía dưới để kiểm tra SingleChildScrollView
              const SizedBox(height: 100),
              const Text("Fixed overflow and layout issues."),
            ],
          ),
        ),
      ),
    );
  }
}