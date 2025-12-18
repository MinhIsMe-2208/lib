import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Bai6Screen(),
    );
  }
}

class Bai6Screen extends StatefulWidget {
  const Bai6Screen({super.key});

  @override
  State<Bai6Screen> createState() => _Bai6ScreenState();
}

class _Bai6ScreenState extends State<Bai6Screen> {
  // Controller để lấy dữ liệu nhập vào (nếu cần xử lý sau này)
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Biến trạng thái để ẩn/hiện mật khẩu
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Nền trắng như ảnh
      appBar: AppBar(
        // Tiêu đề hiển thị theo thiết kế trong ảnh
        title: const Text(
          "Form Đăng nhập",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          // Căn giữa các phần tử theo chiều dọc
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            // --- Ô nhập Tên người dùng ---
            TextField(
              controller: _userController,
              decoration: InputDecoration(
                labelText: "Tên người dùng",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Bo tròn góc
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            
            const SizedBox(height: 20), // Khoảng cách giữa 2 ô

            // --- Ô nhập Mật khẩu ---
            TextField(
              controller: _passController,
              obscureText: _obscureText, // Ẩn văn bản nếu là true
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                prefixIcon: const Icon(Icons.lock),
                // Icon con mắt để ẩn/hiện mật khẩu
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Bo tròn góc
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),

            const SizedBox(height: 40), // Khoảng cách đến nút bấm

            // --- Nút Đăng nhập ---
            SizedBox(
              width: 200, // Độ rộng nút (ước lượng theo ảnh)
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện đăng nhập tại đây
                  print("Đăng nhập: ${_userController.text} - ${_passController.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                // Dùng Row để ghép Icon và Text lại với nhau
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     // Icon mũi tên đăng nhập (gần giống ảnh nhất)
                    Icon(Icons.login_outlined, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Đăng nhập",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}