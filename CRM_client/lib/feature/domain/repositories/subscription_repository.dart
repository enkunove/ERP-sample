import 'dart:ffi';
import 'dart:typed_data';

import 'package:crm_client/feature/domain/entities/subscription.dart';

abstract class SubscriptionRepository{
  Future<List<Subscription>> getAllSubscriptions();
  Future<List<Subscription>> getUserSubscriptions();
  Future<void> purchaseSubscription(int id);
  Future<Uint8List> generateQr(String id);

}