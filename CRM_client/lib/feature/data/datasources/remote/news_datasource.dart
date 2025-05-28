import 'package:dio/dio.dart';

class NewsDatasource{
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>> getAllNews() async {
    try{
      final response = await dio.get("http://192.168.1.42:5294/api/news");
      print(response.data["news"]);
      return response.data["news"].cast<Map<String, dynamic>>();
    } catch (e){
      return [];
    }
  }
}