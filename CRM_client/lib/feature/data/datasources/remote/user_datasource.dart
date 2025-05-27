import 'package:crm_client/core/cookies.dart';
import 'package:dio/dio.dart';

import '../../../../core/service_locator.dart';

class AuthService{
  final Dio dio = Dio();

  Future<String> register(Map data) async{
    final reqUri = "http://192.168.1.42:5294/api/auth/register";
    print(data);
    try {
      final response = await dio.post(
          reqUri,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: data
      );
      if (response.statusCode == 200) {
        return response.data["token"];
      } else {
        throw Exception(
            'Failed to register. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return "false";
    }
  }

  Future<String> login({String password = "", String phone = ""}) async{
    final reqUri = "http://192.168.1.42:5294/api/auth/login";
    try {
      final response = await dio.post(
          reqUri,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: {
            'phone' : phone,
            'password' : password
          }
      );
      if (response.statusCode == 200) {
        return response.data["token"];
      } else {
        throw Exception(
            'Failed to login. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return "false";
    }
  }
  Future<Map<String, dynamic>?> getProfile() async{
    final reqUri = "http://192.168.1.42:5294/api/auth/profile";
    try {
      final token = getIt<Cookies>().cookieData;
      final response = await dio.get(
          reqUri,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),

      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to get profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return Future.value(null);
    }
  }
}