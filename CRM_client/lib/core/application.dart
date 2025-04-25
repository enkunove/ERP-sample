import 'package:crm_client/core/application_theme.dart';
import 'package:crm_client/feature/presentation/view/screens/home_screens/home_wrapper_screen.dart';
import 'package:flutter/material.dart';

import '../feature/presentation/view/screens/auth_screens/start_screen.dart';


class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
      theme: ApplicationTheme.theme,
    );
  }
}
