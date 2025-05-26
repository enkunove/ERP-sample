import 'package:crm_client/core/cookies.dart';
import 'package:crm_client/feature/data/datasources/local/cookies_datasource.dart';
import 'package:crm_client/feature/data/datasources/remote/subscription_datasource.dart';
import 'package:crm_client/feature/data/datasources/remote/user_datasource.dart';
import 'package:crm_client/feature/data/repositories/subscription_repository_impl.dart';
import 'package:crm_client/feature/domain/repositories/auth_repository.dart';
import 'package:crm_client/feature/domain/repositories/subscription_repository.dart';
import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:crm_client/feature/domain/usecases/subscription_usecases.dart';
import 'package:get_it/get_it.dart';

import '../feature/data/repositories/auth_repository_impl.dart';
import '../feature/domain/entities/user.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<User>(() => User(
    name: 'guest',
    surname: 'undefined',
    birthdate: "DateTime(2000)",
    phone: 'undefined',
    sex: true
  ));
  getIt.registerLazySingleton<Cookies>(() => Cookies(cookieData: ""));
  getIt.registerLazySingleton<CookiesDatasource>(() => CookiesDatasource());
  getIt.registerLazySingleton<AuthService>(()=>AuthService());
  getIt.registerLazySingleton<AuthRepository>(()=>AuthRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<AuthUsecases>(()=>AuthUsecases(getIt()));

  getIt.registerLazySingleton<SubscriptionDatasource>(()=>SubscriptionDatasource());
  getIt.registerLazySingleton<SubscriptionRepository>(() => SubscriptionRepositoryImpl(datasource: getIt()));
  getIt.registerLazySingleton<SubscriptionUsecases>(()=>SubscriptionUsecases(getIt()));

  }