import '../entities/user.dart';

abstract class AuthRepository{
  Future<bool> login(String phone, String password);
  Future<User>? getProfile();
}