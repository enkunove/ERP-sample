import 'package:crm_client/feature/domain/entities/news.dart';

class NewsModel extends News {
  NewsModel(super.title, super.payload, super.datePublished);

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      map["title"],
      map["payload"],
      DateTime.parse(map["datePublished"]),
    );
  }
}
