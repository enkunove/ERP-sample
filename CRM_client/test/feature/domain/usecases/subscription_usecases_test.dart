import 'dart:ffi';

import 'package:crm_client/feature/domain/usecases/subscription_usecases.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSubscriptionUsecases extends Mock implements SubscriptionUsecases {}

void main() {
  late SubscriptionUsecases usecases;
  late Uint64 tValue;

  setUp(() {
    usecases = MockSubscriptionUsecases();
    tValue = Uint64();
  });

  group("Subscription", () {
    test("Must return [] when getting all subscriptions", () async {
      when(() => usecases.getAllSubscriptions()).thenAnswer((_) async => []);

      final response = await usecases.getAllSubscriptions();

      expect(response, []);
      verify(() => usecases.getAllSubscriptions()).called(1);
    });

    test("Must return [] when getting user subscriptions", () async {
      when(() => usecases.getUserSubscriptions()).thenAnswer((_) async => []);

      final response = await usecases.getUserSubscriptions();

      expect(response, []);
      verify(() => usecases.getUserSubscriptions()).called(1);
    });

    test("Must return Uint64 when calling QR", () async {
      when(() => usecases.getQrDataBySubscriptionId(1)).thenAnswer((_) async => tValue);

      final response = await usecases.getQrDataBySubscriptionId(1);

      expect(response, tValue);
      verify(() => usecases.getQrDataBySubscriptionId(1)).called(1);
    });

    test("Must call Purchase", () async {
      when(() => usecases.purchaseSubscription(1)).thenAnswer((_) async => true);

      await usecases.purchaseSubscription(1);

      verify(() => usecases.purchaseSubscription(1)).called(1);
    });
  });
}
