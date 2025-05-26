import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/cookies.dart';
import '../../../../core/service_locator.dart';

class CookiesDatasource {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> saveToken() async {
    final token = getIt<Cookies>().cookieData;
    await _storage.write(key: "token", value: token);
  }

  Future<void> rmToken() async {
    await _storage.delete(key: "token");
  }

  Future<String?> getToken() async {
    final token = await _storage.read(key: "token");
    getIt<Cookies>().cookieData = token ?? '';
    return token;
  }
}
