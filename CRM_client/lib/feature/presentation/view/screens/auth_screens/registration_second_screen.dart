import 'package:crm_client/core/custom_page_router.dart';
import 'package:crm_client/feature/presentation/view/screens/auth_screens/registration_third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/dialog_utils.dart';
import '../../../../../core/service_locator.dart';
import '../../../../domain/entities/user.dart';
import '../../widgets/input_widget.dart';

class RegistrationSecondScreen extends StatefulWidget {
  final bool sex;
  final String birthDate;

  const RegistrationSecondScreen({
    super.key,
    required this.sex,
    required this.birthDate,
  });

  @override
  State<RegistrationSecondScreen> createState() =>
      _RegistrationSecondScreenState();
}

class _RegistrationSecondScreenState extends State<RegistrationSecondScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              title: "Имя",
              isPass: false,
              controller: _nameController,
              isNum: false,
            ),
            InputWidget(
                title: "Фамилия",
                isPass: false,
                controller: _surnameController,
                isNum: false),
            InputWidget(
                title: "Номер телефона",
                isPass: false,
                controller: _numberController,
                isNum: true),
            InputWidget(
                title: "Пароль",
                isPass: true,
                controller: _passwordController,
                isNum: false),
            ElevatedButton(
              onPressed: () async {
                if (_nameController.text.isEmpty ||
                    _surnameController.text.isEmpty ||
                    _numberController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  showErrorDialog("Все поля должны быть заполнены.", context);
                  return;
                }
                final phoneRegex = RegExp(r'^\+?\d{10,15}$');
                if (!phoneRegex.hasMatch(_numberController.text)) {
                  showErrorDialog("Некорректный номер телефона.", context);
                  return;
                }

                if (_passwordController.text.length < 6) {
                  showErrorDialog(
                      "Пароль должен быть не менее 6 символов.", context);
                  return;
                }

                getIt<User>()
                  ..name = _nameController.text
                  ..surname = _surnameController.text
                  ..birthdate = widget.birthDate
                  ..phone = _numberController.text;
                // String sub = await _registrationService.register(
                //     _numberController.text, _passwordController.text);

                Navigator.push(
                  context,
                  CustomPageRouter(
                    page: RegistrationThirdScreen(
                        password: _passwordController.text),
                    direction: AxisDirection.up,
                    duration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "ДАЛЕЕ",
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