import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange, // Theme màu cam
        useMaterial3: true,
      ),
      home: const Bai7_1Screen(),
    );
  }
}

class Bai7_1Screen extends StatefulWidget {
  const Bai7_1Screen({super.key});

  @override
  State<Bai7_1Screen> createState() => _Bai7_1ScreenState();
}

class _Bai7_1ScreenState extends State<Bai7_1Screen> {
  // Controller cho các ô nhập liệu
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  
  // Biến lưu giá trị Dropdown (Mặc định chọn 4 sao như trong ảnh)
  String _selectedRating = '4 sao';
  
  // Danh sách lựa chọn
  final List<String> _ratings = [
    '1 sao', '2 sao', '3 sao', '4 sao', '5 sao'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Tiêu đề hiển thị giống thiết kế
        title: const Text(
          "Gửi phản hồi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      // SingleChildScrollView giúp cuộn được màn hình nếu bàn phím hiện lên
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Kéo dãn chiều ngang
          children: [
            
            const SizedBox(height: 10),

            // --- 1. Ô nhập Họ tên ---
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Họ tên",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(), // Viền chữ nhật
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
            ),
            
            const SizedBox(height: 20),

            // --- 2. Dropdown chọn Đánh giá ---
            DropdownButtonFormField<String>(
              value: _selectedRating,
              decoration: const InputDecoration(
                labelText: "Đánh giá (1–5 sao)", // Nhãn trên viền
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              items: _ratings.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedRating = newValue!;
                });
              },
            ),

            const SizedBox(height: 20),

            // --- 3. Ô nhập Nội dung góp ý ---
            TextField(
              controller: _feedbackController,
              maxLines: 5, // Cho phép hiển thị nhiều dòng (tạo khung lớn)
              decoration: const InputDecoration(
                hintText: "Nội dung góp ý", // Hint hiển thị bên trong ô
                border: OutlineInputBorder(),
                alignLabelWithHint: true, 
              ),
            ),

            const SizedBox(height: 30),

            // --- 4. Nút Gửi phản hồi ---
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý gửi dữ liệu
                  print("Gửi: ${_nameController.text} - $_selectedRating");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Nền cam
                  foregroundColor: Colors.white,  // Chữ trắng
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bo tròn 2 đầu
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon gửi (send)
                    Icon(Icons.send, size: 20), 
                    SizedBox(width: 8),
                    Text(
                      "Gửi phản hồi",
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