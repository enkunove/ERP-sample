import 'package:crm_client/core/custom_page_router.dart';
import 'package:crm_client/feature/presentation/view/screens/auth_screens/registration_second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/date_picker_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _selectedIndex = 0;
  int _day = DateTime.now().day;
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void _onDateChanged(int index, int newValue) {
    setState(() {
      if (index == 0) {
        _day = newValue;
      } else if (index == 1) {
        _month = newValue;
      } else if (index == 2) {
        _year = newValue;
      }
      _selectedDate = DateTime(_year, _month, _day);
    });
  }

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
            Text("ПОЛ", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 1
                          ? const Color.fromARGB(255, 249, 203, 0)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text(
                      'Мужской',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: _selectedIndex == 2
                          ? const Color.fromARGB(255, 249, 203, 0)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text(
                      'Женский',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            Text("ДАТА РОЖДЕНИЯ", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 50),
            DatePickerRow(
              day: _day,
              month: _month,
              year: _year,
              isWhite: Theme.of(context).brightness == Brightness.dark ? true: false,
              onDateChanged: _onDateChanged,
            ),
            const SizedBox(height: 20),
            Text(
              '${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 70),
            ElevatedButton(
              onPressed: () {
                if (_selectedIndex != 0) {
                  bool sex = _selectedIndex == 1 ? false : true;
                  final birthDate =
                      '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';

                  Navigator.push(
                    context,
                    CustomPageRouter(
                      page: RegistrationSecondScreen(sex: sex, birthDate: birthDate),
                      direction: AxisDirection.left,
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
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