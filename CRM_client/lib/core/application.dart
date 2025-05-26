import 'package:crm_client/core/application_theme.dart';
import 'package:crm_client/core/cookies.dart';
import 'package:crm_client/core/service_locator.dart';
import 'package:crm_client/feature/data/datasources/local/cookies_datasource.dart';
import 'package:crm_client/feature/data/datasources/remote/user_datasource.dart';
import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:crm_client/feature/presentation/view/screens/auth_screens/start_screen.dart';
import 'package:crm_client/feature/presentation/view/screens/home_screens/home_wrapper_screen.dart';
import 'package:crm_client/feature/presentation/view/screens/home_screens/main_screen.dart';
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
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data == true) {
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
