import 'package:flutter/material.dart';

import '../../../../domain/entities/activity.dart';

class ActivityWidget extends StatelessWidget {
  final Activity activity;
  const ActivityWidget({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(Icons.local_activity),
      title: Text(activity.itemType),
      subtitle: Text(activity.date.toString()),
    );
  }
}
