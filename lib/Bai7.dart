import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // Theme màu xanh lá
        useMaterial3: true,
      ),
      home: const Bai7Screen(),
    );
  }
}

class Bai7Screen extends StatefulWidget {
  const Bai7Screen({super.key});

  @override
  State<Bai7Screen> createState() => _Bai7ScreenState();
}

class _Bai7ScreenState extends State<Bai7Screen> {
  // Controller để lấy dữ liệu
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Biến lưu kết quả
  double? _bmiResult;
  String _bmiMessage = "";
  Color _resultColor = Colors.black;

  // Hàm tính toán BMI
  void _calculateBMI() {
    // Ẩn bàn phím khi bấm nút
    FocusScope.of(context).unfocus();

    // Lấy text và chuyển sang số
    String heightText = _heightController.text;
    String weightText = _weightController.text;

    if (heightText.isEmpty || weightText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!")),
      );
      return;
    }

    try {
      double height = double.parse(heightText);
      double weight = double.parse(weightText);

      // Logic xử lý đơn vị chiều cao:
      // Nếu người dùng nhập > 3 (ví dụ 170), tự hiểu là cm -> chia 100
      // Nếu nhập < 3 (ví dụ 1.7), hiểu là m -> giữ nguyên
      if (height > 3) {
        height = height / 100;
      }

      if (height <= 0 || weight <= 0) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Số liệu không hợp lệ!")),
        );
        return;
      }

      // Công thức BMI = Cân nặng / (Chiều cao * Chiều cao)
      double bmi = weight / (height * height);

      // Phân loại kết quả
      String msg = "";
      Color color = Colors.black;

      if (bmi < 18.5) {
        msg = "Gầy (Thiếu cân)";
        color = Colors.blue;
      } else if (bmi < 24.9) {
        msg = "Bình thường (Sức khỏe tốt)";
        color = Colors.green;
      } else if (bmi < 29.9) {
        msg = "Thừa cân";
        color = Colors.orange;
      } else {
        msg = "Béo phì";
        color = Colors.red;
      }

      setState(() {
        _bmiResult = bmi;
        _bmiMessage = msg;
        _resultColor = color;
      });

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đúng định dạng số!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Tiêu đề App Bar giống trong ảnh
        title: const Text(
          "Tính BMI",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green, // Nền xanh lá
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // --- 1. Nhập Chiều cao ---
            TextField(
              controller: _heightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Chiều cao (m hoặc cm)",
                border: OutlineInputBorder(), // Viền bao quanh
                prefixIcon: Icon(Icons.height),
              ),
            ),
            
            const SizedBox(height: 20),

            // --- 2. Nhập Cân nặng ---
            TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Cân nặng (kg)",
                border: OutlineInputBorder(), // Viền bao quanh
                prefixIcon: Icon(Icons.monitor_weight_outlined),
              ),
            ),

            const SizedBox(height: 30),

            // --- 3. Nút Tính BMI ---
            SizedBox(
              width: double.infinity, // Nút rộng full màn hình
              height: 50,
              child: ElevatedButton(
                onPressed: _calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F0F7), // Màu tím nhạt giống ảnh (hoặc xám nhạt)
                  foregroundColor: const Color(0xFF4A4A4A), // Màu chữ tối
                  elevation: 0, // Không đổ bóng cho giống style phẳng
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Tính BMI",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // --- 4. Hiển thị kết quả (Chỉ hiện khi đã tính) ---
            if (_bmiResult != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _resultColor.withOpacity(0.1), // Màu nền nhạt theo kết quả
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: _resultColor, width: 2),
                ),
                child: Column(
                  children: [
                    const Text("Chỉ số BMI của bạn:", style: TextStyle(fontSize: 16)),
                    Text(
                      _bmiResult!.toStringAsFixed(2), // Lấy 2 số lẻ
                      style: TextStyle(
                        fontSize: 40, 
                        fontWeight: FontWeight.bold,
                        color: _resultColor
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _bmiMessage,
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.w600,
                        color: _resultColor
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}