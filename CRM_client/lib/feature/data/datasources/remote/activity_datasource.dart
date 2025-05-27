import 'package:crm_client/core/cookies.dart';
import 'package:crm_client/core/service_locator.dart';
import 'package:dio/dio.dart';

class ActivityDatasource {
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>> getAllHistory() async{
    final token = getIt<Cookies>().cookieData;
    try{
      final response = await dio.get(
          "http://192.168.1.42:5294/api/visits",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          )
      );
      final rawList = response.data["activities"] as List;
      return rawList.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e){
      return Future.value([]);
    }
  }

}