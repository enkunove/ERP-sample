import 'package:crm_client/core/service_locator.dart';
import 'package:crm_client/feature/domain/usecases/activity_usecases.dart';
import 'package:crm_client/feature/presentation/view/widgets/items/activity_widget.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История посещений'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: getIt<ActivityUsecases>().getAllHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Ошибка загрузки: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("История пуста"));
          }

          final entries = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return ActivityWidget(activity: entries[index]);
            },
          );
        },
      ),
    );
  }
}
