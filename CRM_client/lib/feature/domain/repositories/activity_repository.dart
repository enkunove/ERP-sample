import 'package:crm_client/feature/domain/entities/activity.dart';

abstract class ActivityRepository{
  Future<List<Activity>> getAllHistory();
}