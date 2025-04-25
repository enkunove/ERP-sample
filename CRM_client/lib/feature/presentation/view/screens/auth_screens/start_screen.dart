import 'package:crm_client/feature/presentation/view/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
          }, child: Text("Log in"))
        ],
      ),
    );
  }
}
