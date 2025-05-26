import 'package:crm_client/core/cookies.dart';
import 'package:dio/dio.dart';

import '../../../../core/service_locator.dart';

class AuthService{
  final Dio dio = Dio();

  Future<String> register(Map data) async{
    final reqUri = "http://192.168.184.1:5294/api/auth/register";
    try {
      final response = await dio.post(
          reqUri,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: {
            'name': data["name"],
            'surname' : data["surname"],
            'sex' : data["sex"],
            'phone' : data["phone"],
            'birthDate' : data["birthDate"],
            'password' : data['password']
          }
      );
      print("${response.data}\n${response.headers}\n${response.statusCode}");
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
    final reqUri = "http://192.168.184.1:5294/api/auth/login";
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
      print("${response.data}\n${response.headers}\n${response.statusCode}");
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
    final reqUri = "http://192.168.184.1:5294/api/auth/profile";
    try {
      final token = getIt<Cookies>().cookieData;
      print("TOKEN: $token");
      final response = await dio.get(
          reqUri,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),

      );
      print("API: ${response.data}\n");
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