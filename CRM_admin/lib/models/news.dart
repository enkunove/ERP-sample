class News{
  final String id;
  final String title;
  final String payload;
  final DateTime datePublished;

  News(this.title, this.payload, this.datePublished, this.id);

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      map["title"],
      map["payload"],
      DateTime.parse(map["datePublished"]),
      map["id"]
    );
  }
}