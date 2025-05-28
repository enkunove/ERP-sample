import '../entities/news.dart';
import '../repositories/news_repository.dart';

class NewsUsecases{
  final NewsRepository _repository;

  NewsUsecases(this._repository);

  Future<List<News>> getAllNews() async {
    return await _repository.getAllNews();
  }
}