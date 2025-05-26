
import 'package:crm_client/feature/domain/entities/subscription.dart';

class CacheService{
  // List<ScheduledTrainingRepository>? schedule;
  // List<Activity>? history;
  Subscription? subscription;

  CacheService(this.subscription);

  void clearCache (){
    // schedule = null;
    // history = null;
    subscription = null;
  }
}