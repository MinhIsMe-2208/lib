import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HotelScreen(), // Đổi tên class cho đúng ngữ cảnh
    );
  }
}

class HotelScreen extends StatelessWidget {
  const HotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF003580),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        // --- ĐÃ SỬA LẠI: Xóa "Bài 4", trả về tiêu đề gốc ---
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Text(
              "23 thg 10 – 24 thg 10",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.notifications_none, color: Colors.white)
          )
        ],
      ),
      body: Column(
        children: [
          // Thanh lọc và sắp xếp
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterItem(Icons.swap_vert, "Sắp xếp"),
                _buildFilterItem(Icons.tune, "Lọc"),
                _buildFilterItem(Icons.map_outlined, "Bản đồ"),
              ],
            ),
          ),
          // Danh sách khách sạn
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                const Text(
                  "759 chỗ nghỉ", 
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)
                ),
                const SizedBox(height: 15),
                
                // Item 1
                hotelItem(
                  name: "aNhill Boutique",
                  rating: 9.5,
                  ratingText: "Xuất sắc",
                  reviews: 95,
                  location: "Huế",
                  distance: "0,6km",
                  roomType: "1 suite riêng tư",
                  price: "US\$109",
                  imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500&q=80',
                  hasBreakfast: true,
                ),
                
                // Item 2
                hotelItem(
                  name: "An Nam Hue Boutique",
                  rating: 9.2,
                  ratingText: "Tuyệt hảo",
                  reviews: 34,
                  location: "Cư Chinh",
                  distance: "0,9km",
                  roomType: "1 phòng khách sạn",
                  price: "US\$20",
                  imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=500&q=80',
                  hasBreakfast: true,
                ),
                
                // Item 3
                hotelItem(
                  name: "Hue Jade Hill Villa",
                  rating: 8.0,
                  ratingText: "Rất tốt",
                  reviews: 125,
                  location: "Cư Chinh",
                  distance: "1,3km",
                  roomType: "1 biệt thự nguyên căn",
                  price: "US\$285",
                  imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=500&q=80',
                  hasBreakfast: false,
                ),
                
                // Item 4
                hotelItem(
                  name: "Êm Villa Huế",
                  rating: 8.8,
                  ratingText: "Tuyệt vời",
                  reviews: 12,
                  location: "Thủy Bằng",
                  distance: "2,1km",
                  roomType: "Phòng Deluxe Giường Đôi",
                  price: "US\$45",
                  imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=500&q=80',
                  hasBreakfast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF003580)),
        const SizedBox(width: 5),
        Text(
          label, 
          style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF003580))
        ),
      ],
    );
  }

  Widget hotelItem({
    required String name,
    required double rating,
    required String ratingText,
    required int reviews,
    required String location,
    required String distance,
    required String roomType,
    required String price,
    required String imageUrl,
    bool hasBreakfast = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần ảnh bên trái
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl, width: 120, height: 160, fit: BoxFit.cover),
              ),
              if (hasBreakfast)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF008009),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)
                      ),
                    ),
                    child: const Text(
                      "Bao bữa sáng",
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const Positioned(
                top: 5,
                right: 5,
                child: Icon(Icons.favorite_border, color: Colors.white, size: 20),
              )
            ],
          ),
          const SizedBox(width: 12),
          // Phần thông tin bên phải
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name, 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
                const SizedBox(height: 4),
                // Số sao (giả lập 5 sao)
                const Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    Icon(Icons.star, color: Colors.amber, size: 14),
                  ],
                ),
                const SizedBox(height: 6),
                // Đánh giá
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF003580), 
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Text(
                        "$rating", 
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "$ratingText · $reviews đánh giá", 
                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "📍 $location • Cách $distance", 
                  style: const TextStyle(fontSize: 12, color: Colors.black54)
                ),
                const SizedBox(height: 12),
                
                // Giá và loại phòng
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        roomType, 
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)
                      ),
                      const SizedBox(height: 2),
                      Text(
                        price, 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)
                      ),
                      const Text(
                        "Đã bao gồm thuế và phí", 
                        style: TextStyle(fontSize: 10, color: Colors.grey)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}