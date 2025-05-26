import '../entities/user.dart';

abstract class AuthRepository {
  Future<String> login(String phone, String password, {bool rememberMe = false});
  Future<String> register(
    String name,
    String surname,
    String birthdate,
    String phone,
    bool sex,
    String password
  );
  Future<User?> getProfile();
  Future<bool> saveCookies();
  Future<bool> loadCookies();
}
