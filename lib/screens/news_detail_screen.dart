import 'package:flutter/material.dart';
import '../model/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final News news;

  NewsDetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            news.urlToImage.isNotEmpty
                ? Image.network(news.urlToImage)
                : SizedBox(),
            SizedBox(height: 16),
            Text(
              news.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Tác giả: ${news.author}"),
            SizedBox(height: 8),
            Text("Ngày đăng: ${news.publishedAt}"),
            SizedBox(height: 16),
            Text(
              news.content.isNotEmpty
                  ? news.content
                  : "Không có nội dung chi tiết.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
