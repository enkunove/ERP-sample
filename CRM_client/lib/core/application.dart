import 'package:flutter/material.dart';

import '../feature/presentation/view/screens/auth_screens/start_screen.dart';


class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}
