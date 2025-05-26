import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:crm_client/core/cookies.dart';
import '../../../../core/service_locator.dart';

class SubscriptionDatasource {
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>> getAllSubscriptions() async {
    try {
      final response = await dio.get("http://192.168.1.42:5294/api/products");
      final List<dynamic> rawList = response.data;
      print(rawList);
      return rawList.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Ошибка при получении подписок: $e");
      return [];
    }
  }

  Future<bool> deleteSubscription(String id) async {
    try {
      final token = getIt<Cookies>().cookieData;

      final response = await dio.delete(
          "http://192.168.1.42:5294/api/products/user",
        data: {
          'id' : id
        },
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Ошибка при получении подписок: $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getUserSubscriptions() async {
    try {
      final token = getIt<Cookies>().cookieData;

      final response = await dio.get(
          "http://192.168.1.42:5294/api/products/user",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
      );
      print(response.data);

      final List<dynamic> rawList = response.data["products"];
      return rawList.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Ошибка при получении подписок: $e");
      return [];
    }
  }

  Future<bool> purchase(String id) async {
    try {
      final token = getIt<Cookies>().cookieData;

      final response = await dio.post(
        "http://192.168.1.42:5294/api/products/buy/$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Ошибка при покупке: $e");
      return false;
    }
  }

  Future<Uint8List?> generateQr(String id) async {
    try {
      final token = getIt<Cookies>().cookieData;

      final response = await dio.get(
        "http://192.168.1.42:5294/api/products/user/qr",
        data: {
          'id' : id
        },
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      Uint8List qrImageBytes = Uint8List.fromList(response.data);
      print(qrImageBytes);
      return qrImageBytes;
    } catch (e) {
      print("Ошибка при покупке: $e");
      return null;
    }
  }
}
