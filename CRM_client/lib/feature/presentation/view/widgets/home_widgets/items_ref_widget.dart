import 'package:flutter/material.dart';

import '../../../../../core/custom_page_router.dart';
import '../../screens/home_screens/items_screen.dart';

class ItemsRefWidget extends StatelessWidget {
  const ItemsRefWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRouter(
            page: const ItemsScreen(),
            direction: AxisDirection.left,
            duration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.25),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromARGB(255, 59, 59, 59)
                : const Color.fromARGB(255, 170, 170, 170),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.shopping_cart_rounded, // заменена иконка
                    size: 40,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.7)
                        : Colors.white.withOpacity(0.9),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "Онлайн покупки",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontFamily: "MontserratAlternates",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.7)
                            : Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.7)
                        : Colors.white.withOpacity(0.9),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    Icons.schedule_rounded, // заменена иконка
                    size: 20,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white.withOpacity(0.7)
                        : Colors.white.withOpacity(0.9),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Абонементы и услуги, доступные для оплаты онлайн",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: "MontserratAlternates",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.7)
                            : Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}