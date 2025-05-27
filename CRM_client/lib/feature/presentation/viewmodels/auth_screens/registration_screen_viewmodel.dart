import 'package:crm_client/core/service_locator.dart';
import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/user.dart';

class RegistrationScreenViewModel extends ChangeNotifier{
  String name = "";
  String surname = "";
  String birthDate = "";
  String phone ="";
  bool sex = true;
  String password = "";

  final AuthUsecases _usecases;

  RegistrationScreenViewModel(this._usecases);

  Future<bool> register() async {
    try{
      bool res = await _usecases.register(name, surname, birthDate, phone, sex, password);
      if (res == true){
        getIt<User>()
          ..name = name
          ..surname = surname
          ..birthdate = birthDate
          ..phone = phone
          ..sex = sex;
        return true;
      } else {
          throw Exception();
      }
    } catch (e){
      return  false;
    }
  }

  String? validateFields({
    required String name,
    required String surname,
    required String phone,
    required String password,
  }) {
    if (name.isEmpty || surname.isEmpty || phone.isEmpty || password.isEmpty) {
      return "Все поля должны быть заполнены.";
    }

    final phoneRegex = RegExp(r'^\+?\d{10,15}$');
    if (!phoneRegex.hasMatch(phone)) {
      return "Некорректный номер телефона.";
    }

    if (password.length < 6) {
      return "Пароль должен быть не менее 6 символов.";
    }

    return null; // Всё ок
  }

}