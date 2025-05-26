import 'dart:ffi';
import 'dart:typed_data';

import 'package:crm_client/feature/domain/entities/subscription.dart';

import '../repositories/subscription_repository.dart';

class SubscriptionUsecases{

  final SubscriptionRepository repository;

  SubscriptionUsecases(this.repository);

  Future<List<Subscription>> getAllSubscriptions() async {
    return await repository.getAllSubscriptions();
  }

  Future<Uint8List> generateQr(String id) async{
    return await repository.generateQr(id);
  }

  Future<List<Subscription>> getUserSubscriptions() async {
    return await repository.getUserSubscriptions();

  }

  Future<bool> purchaseSubscription(String id) async {
    return await repository.purchaseSubscription(id);
  }

  Future<bool> deleteSubscription(String id) async {
    return await repository.deleteSubscription(id);
  }
}