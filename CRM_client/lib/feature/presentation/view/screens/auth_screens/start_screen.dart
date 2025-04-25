import 'package:crm_client/feature/presentation/view/screens/auth_screens/login_screen.dart';
import 'package:crm_client/feature/presentation/view/screens/auth_screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/custom_page_router.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  double _topLogoPosition = 300;
  double _buttonOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (mounted) {
        setState(() {
          _topLogoPosition = 200.0;
          _buttonOpacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Stack(
          children: [
            AnimatedPositioned(
              top: _topLogoPosition,
              left: 0,
              right: 0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: SvgPicture.asset("lib/assets/svg/app_logo.svg"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedOpacity(
                    opacity: _buttonOpacity,
                    duration: const Duration(milliseconds: 1000),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Color(0xFF374709),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CustomPageRouter(
                              page: const RegistrationScreen(),
                              direction: AxisDirection.up,
                              duration: const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "РЕГИСТРАЦИЯ",
                            style: TextStyle(
                              color: Color(0xFFF2F2EF),
                              fontFamily: "MontserratAlternates",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  AnimatedOpacity(
                    opacity: _buttonOpacity,
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "уже есть аккаунт?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "MontserratAlternates",
                        fontSize: 14,
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _buttonOpacity,
                    duration: const Duration(milliseconds: 1000),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRouter(
                            page: LoginScreen(),
                            direction: AxisDirection.up,
                            duration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      child: Text(
                        "ВОЙТИ",
                        style: TextStyle(
                          color: Color(0xFF374709),
                          fontFamily: "MontserratAlternates",
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
