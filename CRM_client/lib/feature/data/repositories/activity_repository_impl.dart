import 'package:crm_client/feature/data/datasources/remote/activity_datasource.dart';
import 'package:crm_client/feature/data/models/activity_model.dart';
import 'package:crm_client/feature/domain/entities/activity.dart';
import 'package:crm_client/feature/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository{

  final ActivityDatasource _datasource;
  ActivityRepositoryImpl(this._datasource);

  @override
  Future<List<Activity>> getAllHistory() async {
    final maps = await _datasource.getAllHistory();
    List<ActivityModel> data = [];
    for (var e in maps) {
      data.add(ActivityModel.fromMap(e));
    }
    print(data);
    return data;
  }

}