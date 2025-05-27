import 'package:dio/dio.dart';

class QrService{
    final Dio dio = Dio();

    Future<Map<String, dynamic>> scanQr(String data) async {
      try{
        final response = await dio.post(
            "http://192.168.1.42:5294/api/admin/scan",
            data: {
              "data" : data
            }
        );
        return response.data["payload"];
      } catch (e){
        return {};
      }
    }
}