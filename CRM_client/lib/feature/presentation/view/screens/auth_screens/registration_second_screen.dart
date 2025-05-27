import 'package:crm_client/core/custom_page_router.dart';
import 'package:crm_client/feature/domain/usecases/auth_usecases.dart';
import 'package:crm_client/feature/presentation/view/screens/home_screens/home_wrapper_screen.dart';
import 'package:crm_client/feature/presentation/viewmodels/auth_screens/registration_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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

  late final RegistrationScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<RegistrationScreenViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
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
                final error = viewModel.validateFields(
                  name: _nameController.text,
                  surname: _surnameController.text,
                  phone: _numberController.text,
                  password: _passwordController.text,
                );

                if (error != null) {
                  showErrorDialog(error, context);
                  return;
                }

                viewModel.name = _nameController.text;
                viewModel.surname = _surnameController.text;
                viewModel.phone = _numberController.text;
                viewModel.password = _passwordController.text;
                viewModel.birthDate = widget.birthDate;
                viewModel.sex = widget.sex;

                final success = await viewModel.register();
                if (success) {
                  Navigator.pushReplacement(
                    context,
                    CustomPageRouter(
                      page: HomeScreen(),
                      direction: AxisDirection.up,
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                } else {
                  showErrorDialog("Ошибка регистрации. Попробуйте снова.", context);
                }
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