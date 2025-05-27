import 'package:crm_client/core/cookies.dart';
import 'package:crm_client/core/custom_page_router.dart';
import 'package:crm_client/feature/data/datasources/local/cookies_datasource.dart';
import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:crm_client/feature/presentation/view/screens/auth_screens/start_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/service_locator.dart';
import '../../../domain/entities/user.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 0,
      right: 0,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFFDED3A6),
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                getIt<AuthUsecases>().logOut();
                Navigator.push(
                  context,
                  CustomPageRouter(
                    page: const StartScreen(),
                    direction: AxisDirection.down,
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF759242),
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      getIt<User>().name![0],
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "MontserratAlternates",
                          fontSize: 15),
                    ),
                  )),
            ),
            Spacer(),
            Center(
              child: Text(
                'Здравствуйте, ${getIt<User>().name}',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "MontserratAlternates",
                    fontSize: 15),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}