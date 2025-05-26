import 'package:crm_client/feature/data/datasources/local/cookies_datasource.dart';
import 'package:crm_client/feature/data/datasources/remote/user_datasource.dart';
import 'package:crm_client/feature/domain/entities/user.dart';
import 'package:crm_client/feature/domain/repositories/auth_repository.dart';

import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthService _authService;
  final CookiesDatasource _datasource;

  AuthRepositoryImpl(this._authService, this._datasource);

  @override
  Future<User?> getProfile() async {
    final map = await _authService.getProfile();
    return map != null ? UserModel.fromMap(map!) : null;
  }

  @override
  Future<String> login(String phone, String password, {bool rememberMe = false}) async {
    final token = await _authService.login(password: password, phone: phone);
    return token;
  }

  @override
  Future<String> register(String name, String surname, String birthdate, String phone, bool sex, String password) async {
    return await _authService.register({
      'name': name,
      'surname' : surname,
      'sex' : sex,
      'phone' : phone,
      'birthDate' : birthdate,
      'password' : password,
    });
  }

  @override
  Future<bool> loadCookies() async {
    await _datasource.getToken();
    return true;
  }

  @override
  Future<bool> saveCookies() async{
    await _datasource.saveToken();
    return true;
  }

}