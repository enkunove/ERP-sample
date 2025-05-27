import 'dart:typed_data';

import 'package:crm_client/core/service_locator.dart';
import 'package:crm_client/feature/domain/usecases/subscription_usecases.dart';
import 'package:flutter/material.dart';

class QrScreen extends StatefulWidget {
  final String id;
  const QrScreen({super.key, required this.id});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  late Future<Uint8List> _data;
  final SubscriptionUsecases usecases = getIt<SubscriptionUsecases>();

  @override
  void initState() {
    super.initState();
    _data = usecases.generateQr(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Text(
              'Предъявите QR-код администратору',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                  height: 2,
                  width: constraints.maxWidth,
                  color: Theme.of(context).colorScheme.primary
              );
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color.fromARGB(255, 249, 203, 0)),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Ошибка при загрузке данных'),
                        Text(snapshot.error.toString()),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {

                            });
                          },
                          child: const Text('Попробовать снова'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Нет данных'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Image.memory(snapshot.data!)
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}