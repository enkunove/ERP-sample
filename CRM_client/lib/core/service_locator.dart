import 'package:crm_client/core/cookies.dart';
import 'package:get_it/get_it.dart';

import '../feature/domain/entities/user.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<User>(() => User(
    name: 'guest',
    surname: 'undefined',
    birthdate: DateTime(2000),
    address: 'undefined',
    phone: 'undefined',
  ));
  getIt.registerLazySingleton<Cookies>(() => Cookies(cookieData: []));
  }