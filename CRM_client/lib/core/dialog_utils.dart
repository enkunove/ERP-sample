import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../feature/presentation/view/widgets/date_picker_widget.dart';


void showEditDialog(BuildContext context, String title, String initialValue,
    Function(String) onSave) {
  TextEditingController controller = TextEditingController(text: initialValue);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        backgroundColor: const Color.fromARGB(255, 249, 203, 0),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return TextField(
              cursorColor: Colors.black,
              cursorErrorColor: Colors.black,
              controller: controller,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Arial",
                  fontSize: 20),
              decoration: const InputDecoration(
                labelText: 'Адрес',
                labelStyle: TextStyle(
                    color: Colors.black, fontFamily: "Arial", fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black),
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Отмена',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          TextButton(
            onPressed: () {
              String newValue = controller.text.trim();
              if (newValue.isNotEmpty) {
                onSave(newValue);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Поле не может быть пустым',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    backgroundColor: Theme.of(context).canvasColor,
                  ),
                );
              }
            },
            child: Text('Сохранить',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      );
    },
  );
}
void showConfirmationDialog(
    BuildContext context, String title, String message, Function onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: const Color.fromARGB(255, 249, 203, 0),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Arial",
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Нет',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: Text(
              'Да',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      );
    },
  );
}

void showDateEditDialog(BuildContext context, String title, String initialValue,
    Function(String) onSave) {
  int day = 1, month = 1, year = 2000;
  if (initialValue != "") {
    List<int> dateParts = initialValue.split('-')
        .map((e) => int.parse(e))
        .toList();
    day = dateParts[2];
    month = dateParts[1];
    year = dateParts[0];
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        backgroundColor: const Color.fromARGB(255, 249, 203, 0),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 150,
              padding: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(
                    12), // Rounded corners for the container
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Center the content horizontally
                children: [
                  DatePickerRow(
                    day: day,
                    month: month,
                    year: year,
                    isWhite: Theme.of(context).brightness == Brightness.dark? true : false,
                    onDateChanged: (int type, int value) {
                      setState(() {
                        if (type == 0) day = value;
                        if (type == 1) month = value;
                        if (type == 2) year = value;
                      });
                    },
                  ),
                  const SizedBox(
                      height: 30),
                  Text(
                    '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Отмена',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          TextButton(
            onPressed: () {
              String newValue =
                  '${year.toString()}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
              print(newValue);
              if (newValue.isNotEmpty) {
                onSave(newValue);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Поле не может быть пустым',
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                    ),
                    backgroundColor: Theme.of(context).canvasColor,
                  ),
                );
              }
            },
            child: Text('Сохранить',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      );
    },
  );
}

void showNameEditDialog(BuildContext context, String title, String initialName,
    String initialSurname, Function(String, String) onSave) {
  TextEditingController nameController =
  TextEditingController(text: initialName);
  TextEditingController surnameController =
  TextEditingController(text: initialSurname);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        backgroundColor: const Color.fromARGB(255, 249, 203, 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              cursorColor: Colors.black,
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              controller: nameController,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Arial",
                  fontSize: 20),
              decoration: const InputDecoration(
                labelText: 'Имя',
                labelStyle: TextStyle(
                    color: Colors.black, fontFamily: "Arial", fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black),
                ),
              ),
            ),
            TextField(
              cursorColor: Colors.black,
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              controller: surnameController,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Arial",
                  fontSize: 20),
              decoration: const InputDecoration(
                labelText: 'Фамилия',
                labelStyle: TextStyle(
                    color: Colors.black, fontFamily: "Arial", fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Отмена',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
          TextButton(
            onPressed: () {
              String newName = nameController.text;
              String newSurname = surnameController.text;
              if (newName.isNotEmpty && newSurname.isNotEmpty) {
                onSave(newName, newSurname);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Имя и фамилия не могут быть пустыми',
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black),
                    ),
                    backgroundColor: Theme.of(context).canvasColor,
                  ),
                );
              }
            },
            child: Text('Сохранить',
                style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      );
    },
  );
}

void showPasswordEditDialog(BuildContext context, String title, Future<void> Function(String, String) onSave) {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: Theme.of(context).textTheme.headlineMedium),
        backgroundColor: const Color.fromARGB(255, 249, 203, 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: passwordController,
              obscureText: true,
              cursorColor: Colors.black,
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "Arial",
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                labelText: 'Новый пароль',
                labelStyle: TextStyle(color: Colors.black, fontFamily: "Arial", fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              cursorColor: Colors.black,
              inputFormatters: [
                LengthLimitingTextInputFormatter(15),
              ],
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "Arial",
                fontSize: 20,
              ),
              decoration: const InputDecoration(
                labelText: 'Подтвердите пароль',
                labelStyle: TextStyle(color: Colors.black, fontFamily: "Arial", fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Отмена', style: Theme.of(context).textTheme.headlineSmall),
          ),
          TextButton(
            onPressed: () async {
              String newPassword = passwordController.text;
              String confirmPassword = confirmPasswordController.text;

              if (newPassword.isNotEmpty && confirmPassword.isNotEmpty) {
                if (newPassword == confirmPassword) {
                  // Вызываем функцию для изменения пароля
                  await onSave(newPassword, confirmPassword);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Пароли не совпадают',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      backgroundColor: Theme.of(context).canvasColor,
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Пароли не могут быть пустыми',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    backgroundColor: Theme.of(context).canvasColor,
                  ),
                );
              }
            },
            child: Text('Сохранить', style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      );
    },
  );}

void showErrorDialog(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:
        Text('Ошибка', style: Theme.of(context).textTheme.headlineMedium),
        backgroundColor: const Color.fromARGB(255, 249, 203, 0),
        content: Text(
          message,
          style: const TextStyle(fontFamily: "Arial"),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('ОК', style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      );
    },
  );
}