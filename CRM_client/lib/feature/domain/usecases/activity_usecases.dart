import 'package:crm_client/feature/domain/entities/activity.dart';
import 'package:crm_client/feature/domain/repositories/activity_repository.dart';

class ActivityUsecases{
  final ActivityRepository activityRepository;

  ActivityUsecases(this.activityRepository);

  Future<List<Activity>> getAllHistory() async {
    final r = await activityRepository.getAllHistory();
    print(r);
    return r;
  }

}