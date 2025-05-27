import 'package:crm_client/core/custom_page_router.dart';
import 'package:crm_client/feature/presentation/view/screens/home_screens/home_wrapper_screen.dart';
import 'package:crm_client/feature/presentation/viewmodels/auth_screens/login_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/service_locator.dart';
import '../../widgets/input_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _numberController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<LoginScreenViewmodel>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).canvasColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    height: 200,
                    child: SvgPicture.asset(
                      'lib/assets/svg/app_logo.svg',
                    ),
                  ),
                ),
                const Spacer(),
                InputWidget(
                    title: "номер телефона",
                    isPass: false,
                    controller: _numberController,
                    isNum: true),
                InputWidget(
                    title: "пароль",
                    isPass: true,
                    controller: _passwordController,
                    isNum: false),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      CheckboxTheme(
                        data: CheckboxThemeData(
                          side: BorderSide(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black, // Black border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: Checkbox(
                          value: context.watch<LoginScreenViewmodel>().rememberMe,
                          onChanged: (bool? value) => Provider.of<LoginScreenViewmodel>(context, listen: false).changeRememberMe(value),
                          activeColor: const Color(0xFF759242),
                          checkColor: Colors.black,
                        ),
                      ),
                      const Text(
                        "Запомнить меня",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "MontserratAlternates",
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 100),
                  child: ElevatedButton(
                    onPressed: () async {
                      int response = await context.read<LoginScreenViewmodel>().login(_numberController.text, _passwordController.text);
                      print(response);
                      if (response == 0){
                        Navigator.push(context, CustomPageRouter(
                          page: HomeScreen(),
                          direction: AxisDirection.up
                        ));
                      }
                    },
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Войти",
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        }
      ),
    );
  }
}