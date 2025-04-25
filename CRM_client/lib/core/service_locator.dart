import 'package:crm_client/core/cookies.dart';
import 'package:crm_client/feature/domain/repositories/auth_repository.dart';
import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:get_it/get_it.dart';

import '../feature/data/repositories/auth_repository_impl.dart';
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

  getIt.registerFactory<AuthRepository>(()=>AuthRepositoryImpl());
  getIt.registerFactory<AuthUsecases>(()=>AuthUsecases(getIt()));

  }