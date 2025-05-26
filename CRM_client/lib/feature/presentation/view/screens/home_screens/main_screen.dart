import 'package:crm_client/core/custom_page_router.dart';
import 'package:crm_client/feature/data/datasources/local/cookies_datasource.dart';
import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:crm_client/feature/presentation/view/widgets/home_widgets/subscriptions_ref_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../core/service_locator.dart';
import '../../widgets/home_widgets/history_ref_widget.dart';
import '../../widgets/home_widgets/items_ref_widget.dart';
import '../subscriptions_screen.dart';
import 'items_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final AuthUsecases use = getIt<AuthUsecases>();
  final CookiesDatasource datasource = getIt<CookiesDatasource>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRouter(
                    page: SubscriptionsScreen(),
                    direction: AxisDirection.left,
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                    "Мои подписки",
                    style: TextStyle(
                      fontFamily: "MontserratAlternates",
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color(0xFF374709)

                  ),
                ],
              ),
            ),
          ),
          const SubscriptionsRefWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CustomPageRouter(
                    page: SubscriptionsScreen(),
                    direction: AxisDirection.left,
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                    "История",
                    style: TextStyle(
                      fontFamily: "MontserratAlternates",
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color(0xFF374709)
                  )
                ],
              ),
            ),
          ),
          const HistoryRefWidget(),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10, top: 30),
            child: GestureDetector(
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
              child: Row(
                children: [
                  Text(
                    "Цены",
                    style: TextStyle(
                    fontFamily: "MontserratAlternates",
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color.fromARGB(255, 249, 203, 0),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ItemsRefWidget(),
          ),
          ElevatedButton(onPressed: () async {
            await datasource.rmToken();
          }, child: Text("data"))
        ],
      ),
    );
  }
}
