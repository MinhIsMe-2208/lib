import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple, // Đổi theme sang màu tím
        useMaterial3: true,
      ),
      home: const Bai6_1Screen(),
    );
  }
}

class Bai6_1Screen extends StatefulWidget {
  const Bai6_1Screen({super.key});

  @override
  State<Bai6_1Screen> createState() => _Bai6_1ScreenState();
}

class _Bai6_1ScreenState extends State<Bai6_1Screen> {
  // Controller (tùy chọn, dùng để lấy dữ liệu sau này)
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  // Biến trạng thái để ẩn/hiện mật khẩu (cần 2 biến riêng cho 2 ô)
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Nền trắng/tím nhạt
      appBar: AppBar(
        // Tiêu đề hiển thị đúng như trong ảnh mẫu
        title: const Text(
          "Form Đăng ký tài khoản",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple, // Màu tím
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Dùng SingleChildScrollView để tránh lỗi khi bàn phím hiện lên
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(height: 40), // Khoảng cách từ trên xuống

            // --- 1. Ô nhập Họ tên ---
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Họ tên",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            
            const SizedBox(height: 20),

            // --- 2. Ô nhập Email ---
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),

            const SizedBox(height: 20),

            // --- 3. Ô nhập Mật khẩu ---
            TextField(
              controller: _passController,
              obscureText: _obscurePassword, // Ẩn/Hiện dựa vào biến
              decoration: InputDecoration(
                labelText: "Mật khẩu",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),

            const SizedBox(height: 20),

            // --- 4. Ô Xác nhận mật khẩu ---
            TextField(
              controller: _confirmPassController,
              obscureText: _obscureConfirmPassword, // Biến riêng cho ô xác nhận
              decoration: InputDecoration(
                labelText: "Xác nhận mật khẩu",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),

            const SizedBox(height: 40),

            // --- Nút Đăng ký ---
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý sự kiện đăng ký
                  print("Đăng ký: ${_nameController.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Nền nút màu tím
                  foregroundColor: Colors.white,  // Chữ màu trắng
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_alt_1, size: 20), // Icon thêm người dùng
                    SizedBox(width: 8),
                    Text(
                      "Đăng ký",
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