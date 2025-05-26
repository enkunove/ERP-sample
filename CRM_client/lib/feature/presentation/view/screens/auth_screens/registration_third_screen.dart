import 'package:crm_client/core/custom_page_router.dart';
import 'package:crm_client/feature/presentation/view/screens/home_screens/home_wrapper_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/dialog_utils.dart';
import '../../widgets/input_widget.dart';

class RegistrationThirdScreen extends StatefulWidget {

  final String password;

  const RegistrationThirdScreen({
    super.key, required this.password
  });

  @override
  State<RegistrationThirdScreen> createState() =>
      _RegistrationThirdScreenState();
}

class _RegistrationThirdScreenState extends State<RegistrationThirdScreen> {
  final TextEditingController _codeController = TextEditingController();

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
            InputWidget(title: "Код подтверждения", isPass: false, controller: _codeController, isNum: false,),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () async {
                if (_codeController.text.isEmpty) {
                  showErrorDialog("Все поля должны быть заполнены.", context);
                  return;
                }
                // if (await _registrationService.verify(widget.password, widget.sub, _codeController.text) == true){
                //   print(getIt<User>());
                //   await _authService.login(getIt<User>().number, widget.password);
                //   await _editService.editProfile();
                  Navigator.push(
                    context,
                    CustomPageRouter(
                      page: HomeScreen(),
                      direction: AxisDirection.up,
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                // }
                // else {
                //   print(getIt<User>());
                // }
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