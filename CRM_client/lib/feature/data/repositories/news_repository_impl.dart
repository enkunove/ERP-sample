import 'package:crm_client/feature/data/datasources/remote/news_datasource.dart';
import 'package:crm_client/feature/domain/entities/news.dart';
import 'package:crm_client/feature/domain/repositories/news_repository.dart';

import '../models/news_model.dart';

class NewsRepositoryImpl implements NewsRepository{

  final NewsDatasource _datasource;

  NewsRepositoryImpl(this._datasource);


  @override
  Future<List<News>> getAllNews() async {
    final res = await _datasource.getAllNews();
    final List<NewsModel> list = [];
    for (var item in res){
      list.add(NewsModel.fromMap(item));
    }
    return list;
  }

}