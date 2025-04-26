import 'dart:ffi';

import 'package:crm_client/feature/domain/entities/subscription.dart';

import '../repositories/subscription_repository.dart';

class SubscriptionUsecases{

  final SubscriptionRepository repository;

  SubscriptionUsecases(this.repository);

  Future<List<Subscription>> getAllSubscriptions() async {
    return await repository.getAllSubscriptions();
  }

  Future<Uint64> getQrDataBySubscriptionId(int id) async {
    return await repository.getQrDataBySubscriptionId(id);
  }

  Future<List<Subscription>> getUserSubscriptions() async {
    return await repository.getUserSubscriptions();

  }

  Future<void> purchaseSubscription(int id) async {
  }
}