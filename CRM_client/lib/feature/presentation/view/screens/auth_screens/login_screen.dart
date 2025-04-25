import 'package:crm_client/core/custom_page_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/service_locator.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/usecases/auth_usecases.dart';
import '../../widgets/input_widget.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthUsecases _usecases = AuthUsecases();

  bool _rememberMe = false;
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  'lib/assets/svg/logo.svg',
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
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value!;
                        });
                      },
                      activeColor: const Color.fromARGB(255, 249, 203, 0),
                      checkColor: Colors.black,
                    ),
                  ),
                  const Text(
                    "Запомнить меня",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isButtonDisabled
                  ? null
                  : () async {
                if (_numberController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  return;
                }
                final phoneRegex = RegExp(r'^\+?\d{10,15}$');
                if (!phoneRegex.hasMatch(_numberController.text)) {
                  return;
                }

                setState(() {
                  _isButtonDisabled = true;
                });

                try {
                  int res = await _usecases.login(
                      _numberController.text, _passwordController.text,
                      rememberMe: _rememberMe);
                  if (res == 0) {
                    Map<String, dynamic>? response =
                    await _usecases.getProfile();
                    getIt<User>()
                      ..name = await response?['firstName'] ?? "guest"
                      ..surname = await response?['lastName'] ?? ""
                      ..birthdate = await response?['birthDate'] ?? ""
                      ..phone = await response?['phone'] ?? ""
                      ..address = await response?['address'] ?? "";
                    Navigator.push(
                      context,
                      CustomPageRouter(
                        page: const HomeScreen(),
                        direction: AxisDirection.left,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                    print("navigator pushed");
                  } else {
                    return;
                  }
                } finally {
                  setState(() {
                    _isButtonDisabled = false;
                  });
                }
              },
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Войти",
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}