import 'dart:ffi';
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
    maps.forEach((e) => data.add(SubscriptionModel.fromMap(e)));
    return data;
  }

  @override
  Future<Uint64> getQrDataBySubscriptionId(int id) async {
    return await Future.value(Uint64());
  }

  @override
  Future<List<Subscription>> getUserSubscriptions() async {
    final maps = await _datasource.getUserSubscriptions();
    List<SubscriptionModel> data = [];
    maps.forEach((e) => data.add(SubscriptionModel.fromMap(e)));
    return data;
  }

  @override
  Future<void> purchaseSubscription(int id) async {
  }

  @override
  Future<Uint8List> generateQr(String id) async {
    final data = await _datasource.generateQr(id);
    if (data != null){
      return data;
    } else throw Exception();
  }

}