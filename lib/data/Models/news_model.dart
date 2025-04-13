
class NewsDataModel {
  final String? title, description, urlToImage, publishedAt, content, url, author, sourceName;

  NewsDataModel({
    this.title, this.description, this.urlToImage, this.publishedAt,
    this.content, this.url, this.author, this.sourceName
  });

  factory NewsDataModel.fromJson(Map<String, dynamic> json) {
    return NewsDataModel(
      title: json['title']?.toString() ?? "",
      description: json['description']?.toString() ?? "",
      content: json['content']?.toString() ?? "",
      author: json['author']?.toString() ?? "",
      url: json['url']?.toString() ?? "",
      urlToImage: json['urlToImage']?.toString() ?? "",
      publishedAt: json['publishedAt']?.toString() ?? "",
      sourceName: json['source']?['name']?.toString() ?? "",
    );
  }
}
