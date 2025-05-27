import 'package:crm_client/core/application_theme.dart';
import 'package:crm_client/core/service_locator.dart';
import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:crm_client/feature/presentation/view/screens/auth_screens/start_screen.dart';
import 'package:crm_client/feature/presentation/view/screens/home_screens/home_wrapper_screen.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: getIt<AuthUsecases>().checkAuth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapshot.hasError && snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data == true) {
            return const HomeScreen();
          } else {
            return const StartScreen();
          }
        },
      ),
      theme: ApplicationTheme.theme,
    );
  }
}
