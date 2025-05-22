import 'package:crm_client/feature/data/datasources/remote/subscription_datasource.dart';
import 'package:crm_client/feature/domain/usecases/subscription_usecases.dart';
import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatelessWidget {
  final SubscriptionDatasource _datasource = SubscriptionDatasource();
  SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () async {
          await _datasource.getAllSubscriptions();
        }, child: Text("Pizda")),
      ),
    );
  }
}
