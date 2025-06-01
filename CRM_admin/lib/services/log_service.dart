import 'package:crm_admin/models/log.dart';
import 'package:dio/dio.dart';

class LogService{
  final Dio dio = Dio();
   Future<List<Log>> getLogs() async {
     try{
       final response = await dio.get("http://192.168.1.42:5294/api/admin/logs");
       final maps = response.data as List;
       final List<Log> list = [];
       for (final item in maps){
         list.add(Log.fromJson(item));
       }
       return list;
     }
     catch(e){
       return [];
     }
   }
}