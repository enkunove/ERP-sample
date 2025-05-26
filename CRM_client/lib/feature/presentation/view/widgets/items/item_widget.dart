import 'package:crm_client/feature/data/datasources/remote/subscription_datasource.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/subscription.dart';

class StoreSubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  const StoreSubscriptionCard({
    super.key,
    required this.subscription,
  });

  String _formatDuration(DateTime start, DateTime end) {
    int years = end.year - start.year;
    int months = end.month - start.month;
    int days = end.day - start.day;

    if (days < 0) {
      final prevMonth = DateTime(end.year, end.month, 0);
      days += prevMonth.day;
      months -= 1;
    }

    if (months < 0) {
      months += 12;
      years -= 1;
    }

    final totalMonths = years * 12 + months;

    if (totalMonths > 0 && days > 0) {
      return '$totalMonths мес $days дн';
    } else if (totalMonths > 0) {
      return '$totalMonths мес';
    } else {
      return '$days дн';
    }
  }


  void _showDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(subscription.title),
        content: Text(subscription.description ?? 'Описание отсутствует.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final duration = subscription.expirationDate.difference(subscription.startDate);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0x55759242),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.subscriptions, color: Color(0xFF759242), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subscription.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _showDescriptionDialog(context),
                        icon: const Icon(Icons.info_outline),
                        tooltip: 'Подробнее',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${subscription.price.toStringAsFixed(2)}\$',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        // _formatDuration(subscription.expirationDate, subscription.startDate),
                        "${duration.inDays.toString()} дн.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      SubscriptionDatasource s = SubscriptionDatasource();
                      s.purchase(subscription.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0x99759242),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text('Купить'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
