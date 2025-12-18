import 'package:dio/dio.dart';
import 'package:app/model/news.dart';

class ApiService {
  static final Dio _dio = Dio();

  static Future<List<News>> fetchNews() async {
    const String apiUrl =
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=9acaaa9e08d34ae0b8c986c6ecd4ba5f";

    try {
      final response = await _dio.get(apiUrl);

      if (response.data["status"] != "ok") {
        throw Exception("API lỗi");
      }

      List articles = response.data["articles"];

      return articles.map((json) => News.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Lỗi gọi API: $e");
    }
  }
}
