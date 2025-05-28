import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/activity.dart';

class ActivityWidget extends StatelessWidget {
  final Activity activity;
  final DateFormat dateFormat = DateFormat("dd.MM.yyyy HH:mm");
  ActivityWidget({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.local_activity),
      title: Text(activity.itemType),
      subtitle: Text(dateFormat.format(activity.date)),
    );
  }
}
