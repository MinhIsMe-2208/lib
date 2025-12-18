import 'package:flutter/material.dart';
import '../model/news.dart';
import '../services/api_service.dart';
import 'news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<News>> newsList;

  @override
  void initState() {
    super.initState();
    newsList = ApiService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tin tức WSJ")),
      body: FutureBuilder<List<News>>(
        future: newsList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi tải dữ liệu"));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final news = snapshot.data!;

          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: news[index].urlToImage.isNotEmpty
                    ? Image.network(news[index].urlToImage, width: 90, fit: BoxFit.cover)
                    : Container(width: 90, color: Colors.grey),
                title: Text(news[index].title),
                subtitle: Text(
                  news[index].description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsDetailScreen(news: news[index]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
