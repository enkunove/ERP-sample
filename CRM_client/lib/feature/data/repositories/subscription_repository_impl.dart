import 'dart:typed_data';

import 'package:crm_client/feature/data/datasources/remote/subscription_datasource.dart';
import 'package:crm_client/feature/data/models/subscription_model.dart';
import 'package:crm_client/feature/domain/entities/subscription.dart';
import 'package:crm_client/feature/domain/repositories/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository{

  final SubscriptionDatasource _datasource;

  SubscriptionRepositoryImpl({required SubscriptionDatasource datasource}) : _datasource = datasource;


  @override
  Future<List<Subscription>> getAllSubscriptions() async {
    final maps = await _datasource.getAllSubscriptions();
    List<SubscriptionModel> data = [];
    for (var e in maps) {
      data.add(SubscriptionModel.fromMap(e));
    }
    return data;
  }
  @override
  Future<List<Subscription>> getUserSubscriptions() async {
    final maps = await _datasource.getUserSubscriptions();
    List<SubscriptionModel> data = [];
    for (var e in maps) {
      data.add(SubscriptionModel.fromMap(e));
    }
    return data;
  }

  @override
  Future<bool> purchaseSubscription(String id) async {
    return await _datasource.purchase(id);
  }

  @override
  Future<Uint8List> generateQr(String id) async {
    final data = await _datasource.generateQr(id);
    if (data != null){
      return data;
    } else {
      throw Exception();
    }
  }

  @override
  Future<bool> deleteSubscription(String id) async {
    return await _datasource.deleteSubscription(id);
  }

}