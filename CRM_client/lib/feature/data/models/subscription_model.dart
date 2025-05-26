import 'package:crm_client/feature/domain/entities/subscription.dart';
import 'package:intl/intl.dart';

class SubscriptionModel extends Subscription{
  SubscriptionModel({required super.id, required super.title, required super.price, required super.description, required super.expirationDate, required super.startDate});

  factory SubscriptionModel.fromMap(Map<String, dynamic> map){
    return SubscriptionModel(
        id: map["id"],
        title: map["title"],
        price: double.parse(map["price"].toString()),
        description: map["description"],
        expirationDate: DateTime.tryParse(map["expirationDate"])!,
        startDate: DateTime.tryParse(map["startDate"])!);
  }
}