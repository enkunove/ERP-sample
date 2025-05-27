import 'package:crm_client/feature/domain/entities/activity.dart';

class ActivityModel extends Activity {
  ActivityModel({required super.itemType, required super.date});

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      itemType: map["title"],
      date: DateTime.parse(map["time"]),
    );
  }
}
