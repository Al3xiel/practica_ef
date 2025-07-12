class JsonBook {
  String? title;
  String? author;
  String? urlToImage;
  String? content;
  String? description;

  JsonBook({
    this.title,
    this.author,
    this.urlToImage,
    this.content,
    this.description,
  });

  JsonBook.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    urlToImage = json['urlToImage'];
    content = json['content'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'urlToImage': urlToImage,
      'content': content,
      'description': description,
    };
  }
}