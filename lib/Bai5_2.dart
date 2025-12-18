import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Bai5_2Screen(),
    );
  }
}

class Bai5_2Screen extends StatefulWidget {
  const Bai5_2Screen({super.key});

  @override
  State<Bai5_2Screen> createState() => _Bai5_2ScreenState();
}

class _Bai5_2ScreenState extends State<Bai5_2Screen> {
  // Biến đếm số
  int _counter = 0;

  // Hàm tăng
  void _increment() {
    setState(() {
      _counter++;
    });
  }

  // Hàm giảm
  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  // Hàm reset
  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  // Hàm xác định màu chữ dựa trên giá trị
  Color _getTextColor() {
    if (_counter > 0) return Colors.green; // Số dương màu xanh
    if (_counter < 0) return Colors.red;   // Số âm màu đỏ
    return Colors.black;                   // Số 0 màu đen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Tiêu đề App Bar theo thiết kế (không dùng tiêu đề Bài 5.2)
        title: const Text(
          "Ứng dụng Đếm Số",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Giá trị hiện tại:",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            // Hiển thị số đếm với màu sắc thay đổi
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: _getTextColor(), // Gọi hàm lấy màu
              ),
            ),
            const SizedBox(height: 40),
            
            // Hàng chứa 3 nút bấm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Nút Giảm (Màu đỏ)
                  _buildButton(
                    label: "Giảm",
                    color: Colors.red,
                    icon: Icons.remove,
                    onPressed: _decrement,
                  ),
                  
                  // Nút Đặt lại (Màu xám)
                  _buildButton(
                    label: "Đặt lại",
                    color: Colors.grey,
                    icon: Icons.refresh,
                    onPressed: _reset,
                  ),

                  // Nút Tăng (Màu xanh)
                  _buildButton(
                    label: "Tăng",
                    color: Colors.green,
                    icon: Icons.add,
                    onPressed: _increment,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper để tạo nút bấm cho gọn code
  Widget _buildButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white, // Màu chữ/icon trắng
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(icon, size: 20),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}