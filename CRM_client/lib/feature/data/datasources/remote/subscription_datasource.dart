import 'package:dio/dio.dart';

class SubscriptionDatasource{
  const SubscriptionDatasource();

  Future<List<Map<String, dynamic>>> getAllSubscriptions() async {
    final Dio dio = Dio(BaseOptions());
    final response = await dio.get("http://192.168.184.1:5294/api/products");

    print(response.data);

    final List<dynamic> rawList = response.data;

    final List<Map<String, dynamic>> result =
    rawList.map((item) => item as Map<String, dynamic>).toList();

    return result;
  }


}