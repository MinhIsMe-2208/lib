import 'package:app/Bai1.dart';
import 'package:app/Bai2.dart';
import 'package:app/Bai3.dart';
import 'package:app/Bai4.dart';
import 'package:app/Bai5.dart';
import 'package:app/Bai5_1.dart';
import 'package:app/Bai5_2.dart';
import 'package:app/Bai6.dart';
import 'package:app/Bai6_1.dart';
import 'package:app/Bai7.dart';
import 'package:app/Bai7_1.dart';
import 'package:app/TokenStoragePage.dart';
import 'package:app/my_product.dart';
import 'package:app/screens/news_detail_screen.dart';
import 'package:app/screens/news_list_screen.dart';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tổng Hợp Bài Tập Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Dùng giao diện hiện đại
      ),
      home: const MainNavigator(),
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0; // Biến theo dõi bài tập đang chọn

  // Danh sách tiêu đề bài tập (Khớp với thứ tự trong switch-case)
  final List<String> _titles = [
    "Trang Chủ",                // 0
    "BT1: My Place",            // 1
    "BT2: My Classroom",        // 2
    "BT3: My Guide",            // 3
    "BT4: Booking",             // 4
    "BT5: Change Color",        // 5
    "BT 5.1: Counter App",      // 6
    "BT 5.2: Countdown Timer",  // 7
    "BT 6: Form Login",         // 8
    "BT 6.1: Form Register",    // 9
    "BT 7: BMI Calculator",     // 10
    "BT 7.1: Feedback Form",    // 11
    "BT8: WebAPI",              // 12
    "BT9: NewsAPI",             // 13
    "BT10: Product & Profile",  // 14
  ];

  // Hàm trả về Widget tương ứng với bài tập được chọn
  Widget _getExerciseWidget() {
    switch (_selectedIndex) {
      case 0:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.flutter_dash, size: 100, color: Colors.blue),
              SizedBox(height: 20),
              Text("Chào mừng đến với App Bài Tập", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("Chọn bài tập từ Menu bên trái", style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        );
      
      // --- Các bài tập UI cơ bản ---
       case 1: return const OeschinenLakePage();      // Bài hồ nước Oeschinen
       case 2: return const Bai2Screen();  // Bài danh sách môn học
       case 3: return const GUI();          // Bài Welcome Charlie
       case 4: return const HotelScreen();      // Bài Booking
       case 5: return const ChangeColorApp(); 


      case 6: 
        // return const CounterApp(); // Bài đếm số (Bài 5.1)
        return const Bai5_1Screen();
        
      case 7:
        // return const CountdownTimer(); // Bài đếm ngược (Bài 5.2)
        return const Bai5_2Screen();
      case 8:
        // return const FormLogin(); // Bài Form đăng nhập (Bài 6)
        return const Bai6Screen();

      case 9:
        // return const FormRegister(); // Bài Form đăng ký (Bài 6.1)
        return const Bai6_1Screen();

      case 10:
        // return const BMI(); // Bài tính BMI (Bài 7)
        return const Bai7Screen();

      case 11:
        // return const Request(); // Bài Feedback (Bài 7.1 - Bạn đặt tên là Request)
        return const Bai7_1Screen();
      case 12:
          return  NewsListScreen ();
        case 13:
          return  MyProductScreen ();
        case 14:
          return  TokenStoragePage ();
      default:
        return Center(child: Text("Bài tập ${_titles[_selectedIndex]} chưa được triển khai"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex], style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      // Thanh menu bên trái (Drawer)
      drawer: Drawer(
        child: Column(
          children: [
            // Header của Drawer
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              accountName: Text("Trịnh Công Bình Minh", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              accountEmail: Text("MSSV: 22T1020237"), // Điền MSSV của bạn
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blueAccent),
              ),
            ),
            
            // Danh sách cuộn các bài tập
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _titles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      index == 0 ? Icons.home : Icons.book, 
                      color: _selectedIndex == index ? Colors.blue : Colors.grey
                    ),
                    title: Text(
                      _titles[index],
                      style: TextStyle(
                        color: _selectedIndex == index ? Colors.blue : Colors.black87,
                        fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: _selectedIndex == index,
                    selectedTileColor: Colors.blue.withOpacity(0.1),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                      Navigator.pop(context); // Đóng Drawer sau khi chọn
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: _getExerciseWidget(), // Hiển thị nội dung bài tập
    );
  }
}