import 'package:flutter/material.dart';

// 1. Mô hình dữ liệu cho một khóa học
class Course {
  final String title;
  final String id;
  final int studentCount;
  final Color backgroundColor;
  final IconData decorationIcon; 

  Course({
    required this.title,
    required this.id,
    required this.studentCount,
    required this.backgroundColor,
    required this.decorationIcon,
  });
}


class Bai2Screen extends StatefulWidget {
  const Bai2Screen({super.key});

  @override
  State<Bai2Screen> createState() => _Bai2ScreenState();
}

class _Bai2ScreenState extends State<Bai2Screen> {
  final List<Course> courses = [
    Course(
      title: 'XML và ứng dụng - Nhóm 1',
      id: '2025-2026.1.TIN4583.001',
      studentCount: 58,
      backgroundColor: const Color(0xFF344955),
      decorationIcon: Icons.monetization_on,
    ),
    Course(
      title: 'Lập trình ứng dụng cho các t...',
      id: '2025-2026.1.TIN4403.006',
      studentCount: 55,
      backgroundColor: const Color(0xFF4A6572),
      decorationIcon: Icons.book,
    ),
    Course(
      title: 'Lập trình ứng dụng cho các t...',
      id: '2025-2026.1.TIN4403.005',
      studentCount: 52,
      backgroundColor: const Color(0xFF4A6572),
      decorationIcon: Icons.book,
    ),
    Course(
      title: 'Lập trình ứng dụng cho các t...',
      id: '2025-2026.1.TIN4403.004',
      studentCount: 50,
      backgroundColor: const Color(0xFF1E88E5),
      decorationIcon: Icons.school,
    ),
    Course(
      title: 'Lập trình ứng dụng cho các t...',
      id: '2025-2026.1.TIN4403.003',
      studentCount: 52,
      backgroundColor: const Color(0xFF344955),
      decorationIcon: Icons.monetization_on,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // --- ĐÃ SỬA TÊN Ở ĐÂY ---
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true, // Căn giữa tiêu đề cho đẹp
        titleTextStyle: const TextStyle(
          color: Colors.black, 
          fontSize: 20, 
          fontWeight: FontWeight.bold
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(course: courses[index]);
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            color: course.backgroundColor,
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: Opacity(
                  opacity: 0.2,
                  child: Icon(
                    course.decorationIcon,
                    size: 120,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            course.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_horiz, color: Colors.white),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.id,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${course.studentCount} học viên',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}