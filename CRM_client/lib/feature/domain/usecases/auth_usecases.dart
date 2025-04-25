class AuthUsecases{
  Future<int> login(String phone, String password, {bool rememberMe = false}){
    return Future.value();
  }

  Future<Map<String, dynamic>>? getProfile(){
    return Future.value();
  }
}