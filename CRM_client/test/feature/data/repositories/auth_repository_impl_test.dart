import 'package:flutter_test/flutter_test.dart';
import 'package:crm_client/feature/data/repositories/auth_repository_impl.dart';
import 'package:crm_client/feature/domain/entities/user.dart';

void main() {
  late AuthRepositoryImpl repository;

  setUp(() {
    repository = AuthRepositoryImpl();
  });

  group('AuthRepositoryImpl', () {
    test('login() returns true', () async {
      final result = await repository.login("+375291824044", "password");
      expect(result, true);
    });

    test('getProfile() returns a User with expected data', () async {
      final result = await repository.getProfile();
      expect(result, isA<User>());
      expect(result?.name, "Egor");
      expect(result?.surname, "Shevkunov");
      expect(result?.phone, "+375291824044");
      expect(result?.address, "-");
      expect(result?.birthdate, isA<DateTime>());
    });
  });
}
