import 'package:crm_client/core/custom_page_router.dart';
import 'package:crm_client/feature/domain/entities/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubscriptionsRefWidget extends StatefulWidget {
  const SubscriptionsRefWidget({super.key});

  @override
  _SubscriptionsRefWidgetState createState() => _SubscriptionsRefWidgetState();
}

class _SubscriptionsRefWidgetState extends State<SubscriptionsRefWidget> {
  bool _isButtonDisabled = false;


  Future<void> _showQrScreen(Subscription subscription) async {
    if (_isButtonDisabled) return;
    setState(() {
      _isButtonDisabled = true;
    });

    try {
      // await Navigator.push(
      //   context,
      //   CustomPageRouter(
      //     page: QrScreen(id: getIt<CacheService>().membership!.id),
      //     direction:
      //     AxisDirection.left,
      //     duration: const Duration(
      //         milliseconds: 500),
      //   ),
      // );
    } finally {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  Future<Subscription> subscription = Future.value(Subscription(id: "0", title: "Подписка на месяц unlimited", description: "", expirationDate: DateTime(2025, 12, 20), startDate: DateTime.now(), price: 0));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: FutureBuilder<Subscription?>(
        future: subscription,
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
                                  "Нет доступных подписок",
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