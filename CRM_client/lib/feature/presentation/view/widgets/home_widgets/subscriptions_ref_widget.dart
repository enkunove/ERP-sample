import 'package:crm_client/core/custom_page_router.dart';
import 'package:crm_client/feature/domain/entities/subscription.dart';
import 'package:crm_client/feature/domain/usecases/subscription_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/service_locator.dart';
import '../../../../data/datasources/local/cache_service.dart';
import '../../screens/qr_screen.dart';


class SubscriptionsRefWidget extends StatefulWidget {
  const SubscriptionsRefWidget({super.key});

  @override
  _SubscriptionsRefWidgetState createState() => _SubscriptionsRefWidgetState();
}

class _SubscriptionsRefWidgetState extends State<SubscriptionsRefWidget> {
  bool _isButtonDisabled = false;
  final SubscriptionUsecases _usecases = getIt<SubscriptionUsecases>();

  Future<Subscription?> _loadMembership() async {
    if (getIt<CacheService>().subscription == null) {
      final subs = await _usecases
          .getUserSubscriptions();
      getIt<CacheService>().subscription = subs.isNotEmpty ? subs[0] : null;
      return subs.isNotEmpty ? subs[0] : null;
    }
    else {
      return getIt<CacheService>().subscription;
    }
  }

  Future<void> _showQrScreen(Subscription sub) async {
    if (_isButtonDisabled) return;

    setState(() {
      _isButtonDisabled = true;
    });

    try {
      await Navigator.push(
        context,
        CustomPageRouter(
          page: QrScreen(id: getIt<CacheService>().subscription!.id),
          direction:
          AxisDirection.left,
          duration: const Duration(
              milliseconds: 500),
        ),
      );
    } finally {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: FutureBuilder<Subscription?>(
        future: _loadMembership(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final membership = snapshot.data;

          if (membership == null) {
            return Center(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.dark
                          ? const Color.fromARGB(255, 59, 59, 59) : const Color.fromARGB(255, 170, 170, 170),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Text(
                                  "Нет доступных абонементов",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontFamily: "MontserratAlternates",
                                    fontSize: 16,
                                    color: theme.brightness == Brightness.dark
                                        ? Colors.white.withOpacity(0.7)
                                        : Colors.black.withOpacity(0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                        ])));
          }

          return GestureDetector(
            onTap: () => _showQrScreen(membership),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? const Color.fromARGB(255, 59, 59, 59) : const Color.fromARGB(255, 170, 170, 170),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            membership.title,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontFamily: "MontserratAlternates",
                              fontSize: 16,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.white.withOpacity(0.9),
                            ),
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 20),
                          if (membership.expirationDate != null )Text(
                            "Истекает ${membership.expirationDate!.toLocal().toString().split(' ')[0]}",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontFamily: "MontserratAlternates",
                              fontSize: 12,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.white.withOpacity(0.9),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: SvgPicture.asset(
                      "lib/assets/svg/qr.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}