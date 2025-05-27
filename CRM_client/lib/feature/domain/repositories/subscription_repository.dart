import 'dart:typed_data';

import 'package:crm_client/feature/domain/entities/subscription.dart';

abstract class SubscriptionRepository{
  Future<List<Subscription>> getAllSubscriptions();
  Future<List<Subscription>> getUserSubscriptions();
  Future<bool> purchaseSubscription(String id);
  Future<Uint8List> generateQr(String id);
  Future<bool> deleteSubscription(String id);
}