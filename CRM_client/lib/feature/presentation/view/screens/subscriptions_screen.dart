import 'package:crm_client/feature/data/datasources/remote/subscription_datasource.dart';
import 'package:crm_client/feature/domain/usecases/subscription_usecases.dart';
import 'package:crm_client/feature/presentation/view/widgets/items/subscription_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/service_locator.dart';
import '../../../domain/entities/subscription.dart';

class SubscriptionsScreen extends StatefulWidget {
  SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  late Future<List<Subscription>> _subscriptionsFuture;

  final SubscriptionUsecases usecases = getIt<SubscriptionUsecases>();

  @override
  void initState() {
    super.initState();
    _subscriptionsFuture = usecases.getUserSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Text(
              'Активные подписки:',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                  height: 2,
                  width: constraints.maxWidth,
                  color: Theme.of(context).colorScheme.primary
              );
            },
          ),
          Expanded(
            child: FutureBuilder<List<Subscription>>(
              future: _subscriptionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color.fromARGB(255, 249, 203, 0)),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Ошибка при загрузке данных'),
                        Text(snapshot.error.toString()),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {

                            });
                          },
                          child: const Text('Попробовать снова'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Нет данных'));
                } else {
                  final entries = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: entries.map((item) => SubscriptionWidget(subscription: item)).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
