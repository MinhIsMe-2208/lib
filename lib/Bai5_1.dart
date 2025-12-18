import 'dart:async'; // Cần import thư viện này để dùng Timer
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Timer Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Bai5_1Screen(),
    );
  }
}

class Bai5_1Screen extends StatefulWidget {
  const Bai5_1Screen({super.key});

  @override
  State<Bai5_1Screen> createState() => _Bai5_1ScreenState();
}

class _Bai5_1ScreenState extends State<Bai5_1Screen> {
  // 1. Khởi tạo TextEditingController để lấy dữ liệu nhập vào
  final TextEditingController _controller = TextEditingController();
  
  // Biến quản lý Timer và số giây hiện tại
  Timer? _timer;
  int _currentSeconds = 0;
  bool _isTimerRunning = false;

  @override
  void dispose() {
    // 3. Quan trọng: Hủy Timer khi widget bị đóng để tránh rò rỉ bộ nhớ
    if (_timer != null) {
      _timer!.cancel();
    }
    _controller.dispose();
    super.dispose();
  }

  // Hàm bắt đầu đếm ngược
  void _startTimer() {
    // Lấy số giây từ ô nhập liệu
    int? seconds = int.tryParse(_controller.text);

    if (seconds == null || seconds <= 0) {
      // Hiển thị thông báo nếu nhập sai
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số giây hợp lệ! (> 0)')),
      );
      return;
    }

    // Reset lại trạng thái nếu đang chạy
    if (_timer != null) {
      _timer!.cancel();
    }

    setState(() {
      _currentSeconds = seconds;
      _isTimerRunning = true;
    });

    // 2. Sử dụng Timer.periodic từ dart:async
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentSeconds > 0) {
          _currentSeconds--;
        } else {
          // Hết giờ
          _timer!.cancel();
          _isTimerRunning = false;
          _showTimeUpDialog(); // Hiển thị thông báo
        }
      });
    });
  }

  // Hàm hiển thị thông báo Hết giờ
  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Thông báo"),
        content: const Row(
          children: [
            Icon(Icons.alarm, color: Colors.red),
            SizedBox(width: 10),
            Text("⏰ Hết thời gian!", style: TextStyle(fontSize: 18)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Đóng"),
          ),
        ],
      ),
    );
  }

  // Hàm format giây thành dạng MM:SS (Ví dụ: 90s -> 01:30)
  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    // padLeft(2, '0') để luôn hiển thị 2 chữ số (ví dụ: 05 thay vì 5)
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Tiêu đề theo thiết kế trong ảnh (không để Bài 5.1)
        title: const Text(
          "Bộ đếm thời gian",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ô nhập liệu
            const Text(
              "Nhập số giây cần đếm:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number, // Chỉ cho nhập số
              decoration: InputDecoration(
                hintText: "Ví dụ: 10",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            
            const SizedBox(height: 40),

            // Hiển thị đồng hồ đếm ngược
            Text(
              _formatTime(_currentSeconds),
              style: TextStyle(
                fontSize: 80, 
                fontWeight: FontWeight.bold,
                color: _isTimerRunning ? Colors.blue : Colors.black54,
              ),
            ),

            const SizedBox(height: 40),

            // Nút Bắt đầu
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Bắt đầu",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}