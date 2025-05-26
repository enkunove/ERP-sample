import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crm_client/feature/presentation/view/screens/auth_screens/start_screen.dart';
import 'package:crm_client/feature/presentation/view/screens/auth_screens/registration_first_screen.dart';
import 'package:crm_client/feature/presentation/view/screens/auth_screens/login_screen.dart';

void main() {
  testWidgets('StartScreen -> RegistrationScreen and LoginScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: StartScreen(),
    ));

    await tester.pumpAndSettle();

    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();


    final registrationButton = find.text('РЕГИСТРАЦИЯ');

    expect(registrationButton, findsOneWidget);

    await tester.tap(registrationButton);
    await tester.pumpAndSettle();

    expect(find.byType(RegistrationScreen), findsOneWidget);

    await tester.pumpAndSettle();

  });
}
