class JsonBook {
  String? title;
  String? author;
  String? url;
  String? urlToImage;
  String? content;
  String? publishedAt;

  JsonBook({
    this.title,
    this.author,
    this.url,
    this.urlToImage,
    this.content,
    this.publishedAt,
  });

  JsonBook.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    content = json['content'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'url': url,
      'urlToImage': urlToImage,
      'content': content,
      'publishedAt': publishedAt,
    };
  }
}