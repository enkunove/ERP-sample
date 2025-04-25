import 'package:crm_client/feature/domain/entities/user.dart';
import 'package:crm_client/feature/domain/repositories/auth_repository.dart';

import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<User>? getProfile() async {
    return UserModel(name: "Egor", surname: "Shevkunov", address: "-", phone: "+375291824044", birthdate: DateTime.now());
  }

  @override
  Future<bool> login(String phone, String password) {
    return Future.value(true);
  }

}