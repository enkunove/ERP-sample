import 'package:dio/dio.dart';

import '../models/news.dart';

class NewsService{
  final Dio dio = Dio();

  Future<void> postNews(String title, String payload) async {
    await dio.post(
        "http://192.168.1.42:5294/api/news",
        data: {
          "title" : title,
          "payload" : payload
        });

  }

  Future<void> deleteNews(String id) async {
    await dio.delete(
        "http://192.168.1.42:5294/api/news",
        data: {
          "id" : id,
        });

  }

  Future<List<News>> getAllNews() async {
    try{
      final response = await dio.get("http://192.168.1.42:5294/api/news");
      print(response.data["news"]);
      final maps =  response.data["news"].cast<Map<String, dynamic>>();
      List<News> list = [];
      for(var item in maps){
        list.add(News.fromMap(item));
      }
      return list;
    } catch (e){
      return [];
    }
  }
}