import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:crm_client/feature/presentation/viewmodels/auth_screens/login_screen_viewmodel.dart';
import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:crm_client/core/service_locator.dart';

class MockAuthUsecases extends Mock implements AuthUsecases {}

void main() {
  late MockAuthUsecases mockUsecases;
  late LoginScreenViewmodel viewmodel;

  setUp(() {
    mockUsecases = MockAuthUsecases();
    getIt.registerSingleton<AuthUsecases>(mockUsecases);
    viewmodel = LoginScreenViewmodel();
  });

  tearDown(() {
    getIt.reset();
  });

  group('LoginScreenViewmodel login()', () {
    test('returns -1 when phone or password is empty', () async {
      final result = await viewmodel.login("", "");
      expect(result, -1);
    });

    test('returns -1 when phone format is invalid', () async {
      final result = await viewmodel.login("1234", "password");
      expect(result, -1);
    });

    test('returns 0 when login is successful', () async {
      when(() => mockUsecases.login(any(), any(), rememberMe: any(named: 'rememberMe')))
          .thenAnswer((_) async => true);

      final result = await viewmodel.login("+12345678901", "password");
      expect(result, 0);
      verify(() => mockUsecases.login("+12345678901", "password", rememberMe: false)).called(1);
    });

    test('returns 1 when login fails', () async {
      when(() => mockUsecases.login(any(), any(), rememberMe: any(named: 'rememberMe')))
          .thenAnswer((_) async => false);

      final result = await viewmodel.login("+12345678901", "wrongpassword");
      expect(result, 1);
    });

    test('remembers user when checkbox is checked', () async {
      viewmodel.changeRememberMe(true);
      expect(viewmodel.rememberMe, true);
    });
  });
}
