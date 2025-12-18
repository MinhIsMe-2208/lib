class News {
  final String title;
  final String description;
  final String urlToImage;
  final String content;
  final String author;
  final String publishedAt;

  News({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.content,
    required this.author,
    required this.publishedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json["title"] ?? "No title",
      description: json["description"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      content: json["content"] ?? "",
      author: json["author"] ?? "Unknown",
      publishedAt: json["publishedAt"] ?? "",
    );
  }
}
