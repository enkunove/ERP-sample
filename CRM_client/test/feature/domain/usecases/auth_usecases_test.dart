import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthUsecases extends Mock implements AuthUsecases {}

void main() {
  late AuthUsecases usecases;

  setUp(() {
    usecases = MockAuthUsecases();
  });

  group("Authentication", () {
    test("Must return true when log in", () async {
      when(() => usecases.login(any(), any())).thenAnswer((_) async => true);

      final response = await usecases.login("phone", "password");

      expect(response, true);
      verify(() => usecases.login("phone", "password")).called(1);
    });

    test("Must return true when getting profile", () async {
      when(() => usecases.getProfile()).thenAnswer((_) async => true);

      final response = await usecases.getProfile();

      expect(response, true);
      verify(() => usecases.getProfile()).called(1);
    });
  });
}
