import 'package:crm_client/feature/data/datasources/local/cache_service.dart';
import 'package:crm_client/feature/domain/repositories/auth_repository.dart';
import '../../../core/cookies.dart';
import '../../../core/service_locator.dart';
import '../../data/datasources/local/cookies_datasource.dart';
import '../entities/user.dart';

class AuthUsecases{
  final AuthRepository repository;
  AuthUsecases(this.repository);

  Future<bool> login(String phone, String password, {bool rememberMe = false}) async{
    try{
      String token = await repository.login(phone, password);
      print("token: $token ");
      getIt<Cookies>().cookieData = token;
      await getProfile();
      if (rememberMe){
        await repository.saveCookies();
      }
      return true;
    } catch (e){
      return false;
    }
  }

  Future<bool> register(String name, String surname, String birthdate, String phone, bool sex, String password) async {
    try{
      getIt<Cookies>().cookieData = await repository.register(name, surname, birthdate, phone, sex, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool logOut(){
    try{
      getIt<Cookies>().cookieData = "";
      getIt<CookiesDatasource>().rmToken();
      getIt<CacheService>().subscription = null;
      getIt<User>()
        ..name = 'guest'
        ..surname = 'undefined'
        ..birthdate = "DateTime(2000)"
        ..phone = 'undefined'
        ..sex = true;
      return true;
    } catch(e){
      return false;
    }
  }

  Future<User?> getProfile() async {
    try {
      final response = await repository.getProfile();
      if (response == null) return null;

      final user = getIt<User>();
      user
        ..name = response.name ?? ''
        ..surname = response.surname ?? ''
        ..birthdate = response.birthdate ?? ''
        ..sex = response.sex ?? false
        ..phone = response.phone ?? '';


      return user;
    } catch (e) {
      print('Error in getProfile: $e');
      return null;
    }
  }

  Future<bool> checkAuth() async {
    final token = await getIt<CookiesDatasource>().getToken();
    if (token == null || token.isEmpty) return false;
    final res = await getProfile();
    return (res != null);
  }
}