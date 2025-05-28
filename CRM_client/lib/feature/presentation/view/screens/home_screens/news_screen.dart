import 'package:crm_client/core/service_locator.dart';
import 'package:crm_client/feature/domain/usecases/news_usecases.dart';
import 'package:crm_client/feature/presentation/view/widgets/items/news_widget.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: FutureBuilder(
        future: getIt<NewsUsecases>().getAllNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 249, 203, 0),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ошибка при загрузке данных'),
                  Text(snapshot.error.toString()),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет данных'));
          } else {
            final entries = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children:
                      entries
                          .map(
                            (item) => NewsWidget(news: item),
                          )
                          .toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
