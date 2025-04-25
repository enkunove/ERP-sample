class Cookies{
  String get jwt {
    return cookieData.firstWhere((e) => e =="JWT");
  }
  String get refreshToken {
    return cookieData.firstWhere((e) => e == "REFRESH_TOKEN");
  }

  List<String> cookieData;

  Cookies({required this.cookieData});

}