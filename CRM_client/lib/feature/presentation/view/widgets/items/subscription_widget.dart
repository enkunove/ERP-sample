import 'package:crm_client/feature/presentation/view/screens/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/subscription.dart';

class SubscriptionWidget extends StatelessWidget {
  final Subscription subscription;
  final VoidCallback? onDelete;

  const SubscriptionWidget({super.key, required this.subscription, this.onDelete});

  double getProgress() {
    final now = DateTime.now();
    final totalDuration = subscription.expirationDate.difference(subscription.startDate).inSeconds;
    final elapsed = now.difference(subscription.startDate).inSeconds;

    if (elapsed <= 0) return 0;
    if (elapsed >= totalDuration) return 1;
    return elapsed / totalDuration;
  }

  @override
  Widget build(BuildContext context) {
    final progress = getProgress();
    final dateFormat = DateFormat('dd.MM.yyyy');

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> QrScreen(id: subscription.id)));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      subscription.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(onPressed: onDelete,
                      icon: Icon(Icons.delete))
                ],
              ),

              const SizedBox(height: 8),

              if (subscription.description != null && subscription.description!.isNotEmpty)
                Text(
                  subscription.description!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start: ${dateFormat.format(subscription.startDate)}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    'Expires: ${dateFormat.format(subscription.expirationDate)}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
                ),
              ),

              const SizedBox(height: 4),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${(progress * 100).toStringAsFixed(1)}% used',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
