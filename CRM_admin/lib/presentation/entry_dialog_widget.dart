import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EntryDialogWidget extends StatelessWidget {
  final EntryModel model;

  const EntryDialogWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy');

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Пропуск действителен"),
            const SizedBox(height: 12),
            _infoRow("Имя", model.name),
            _infoRow("Фамилия", model.surname),
            _infoRow("Подписка", model.title),
            _infoRow("Начало", dateFormat.format(model.startDate)),
            _infoRow("Истекает", dateFormat.format(model.expirationDate)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Ок"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label:", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}


class EntryModel {
  final String name;
  final String surname;
  final String title;
  final DateTime startDate;
  final DateTime expirationDate;

  EntryModel({
    required this.name,
    required this.surname,
    required this.title,
    required this.startDate,
    required this.expirationDate,
  });

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
      name: json['name'],
      surname: json['surname'],
      title: json['title'],
      startDate: DateTime.parse(json['startDate']),
      expirationDate: DateTime.parse(json['expirationDate']),
    );
  }
}
