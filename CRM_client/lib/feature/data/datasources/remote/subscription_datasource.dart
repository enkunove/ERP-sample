import 'package:dio/dio.dart';

class SubscriptionDatasource{
  const SubscriptionDatasource();

  Future<Map<String, dynamic>> getAllSubscriptions() async {
    final Dio dio = Dio(BaseOptions());
    final response = await dio.get("http://192.168.184.1:5294/api/products");


    print(response.data);
      return response.data;
  }

}