import 'package:flutter/cupertino.dart';

import '../../../domain/usecases/auth_usecases.dart';

class LoginScreenViewmodel extends ChangeNotifier {
  final AuthUsecases _usecases;
  bool _isButtonDisabled = false;
  bool rememberMe = false;

  LoginScreenViewmodel(this._usecases);

  void changeRememberMe(bool? value) {
    rememberMe = value!;
    notifyListeners();
  }

  Future<int> login(String phone, String password) async {
    if (_isButtonDisabled) return -1;

    if (phone.isEmpty || password.isEmpty) return -1;

    final phoneRegex = RegExp(r'^\+?\d{10,15}$');
    if (!phoneRegex.hasMatch(phone)) return -1;

    _isButtonDisabled = true;

    try {
      bool res = await _usecases.login(
        phone,
        password,
        rememberMe: rememberMe,
      );
      return res ? 0 : 1;
    } finally {
      _isButtonDisabled = false;
    }
  }
}
