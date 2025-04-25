import 'package:crm_client/feature/domain/repositories/auth_repository.dart';

import '../../../core/service_locator.dart';
import '../entities/user.dart';

class AuthUsecases{
  final AuthRepository repository;
  AuthUsecases(this.repository);

  Future<bool> login(String phone, String password, {bool rememberMe = false}){
    return Future.value(true);
  }

  Future<bool> getProfile() async{
    User? response =
        await repository.getProfile();
    if (response == null){
      return false;
    }
    getIt<User>()
      ..name = response.name
      ..surname = response.surname
      ..birthdate = response.birthdate
      ..phone = response.phone
      ..address = response.address;
    return true;
  }
}