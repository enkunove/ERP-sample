import 'package:flutter/material.dart';
import '../models/news.dart';
import '../services/news_service.dart'; // путь подкорректируй

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final _titleController = TextEditingController();
  final _payloadController = TextEditingController();
  final NewsService _newsService = NewsService();
  late Future<List<News>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _newsService.getAllNews();
  }

  Future<void> _submitNews() async {
    final title = _titleController.text.trim();
    final payload = _payloadController.text.trim();

    if (title.isEmpty || payload.isEmpty) return;

    await _newsService.postNews(title, payload);
    _titleController.clear();
    _payloadController.clear();

    setState(() {
      _newsFuture = _newsService.getAllNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Управление новостями'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Заголовок'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _payloadController,
                      decoration: const InputDecoration(labelText: 'Содержание'),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _submitNews,
                      icon: const Icon(Icons.send),
                      label: const Text('Опубликовать'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: FutureBuilder<List<News>>(
                future: _newsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Ошибка: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Новостей пока нет.'));
                  }

                  final newsList = snapshot.data!.reversed.toList();
                  return ListView.separated(
                    itemCount: newsList.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final news = newsList[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                news.title,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(news.payload),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await _newsService.deleteNews(news.id);
                                        setState(() {
                                          _newsFuture = _newsService.getAllNews();
                                        });
                                       },
                                      icon: Icon(Icons.delete)),
                                  Spacer(),
                                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${news.datePublished.day.toString().padLeft(2, '0')}.${news.datePublished.month.toString().padLeft(2, '0')}.${news.datePublished.year} "
                                        "${news.datePublished.hour.toString().padLeft(2, '0')}:${news.datePublished.minute.toString().padLeft(2, '0')}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
