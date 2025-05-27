
import 'package:flutter/material.dart';

import '../../../../../core/custom_page_router.dart';
import '../../../../domain/entities/activity.dart';
import '../../screens/history_screen.dart';
import '../entry_widget.dart';

class HistoryRefWidget extends StatefulWidget {
  const HistoryRefWidget({super.key});

  @override
  _HistoryRefWidgetState createState() => _HistoryRefWidgetState();
}

class _HistoryRefWidgetState extends State<HistoryRefWidget> {
  bool _isButtonDisabled = false;

  final Future<List<Activity>> _activities = Future.value([
    Activity(itemType: "VISIT", date: DateTime(2025, 4, 20)),
    Activity(itemType: "PURCHASE", date: DateTime(2025, 4, 21)),
    Activity(itemType: "VISIT", date: DateTime(2025, 4, 23))
  ]);

  Future<void> _showHistoryScreen() async {
    if (_isButtonDisabled) return;
    setState(() {
      _isButtonDisabled = true;
    });

    try {
      await Navigator.push(
        context,
        CustomPageRouter(
          page: const HistoryScreen(),
          direction: AxisDirection.left,
          duration: const Duration(milliseconds: 500),
        ),
      );
    } finally {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _activities,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: _showHistoryScreen,
              child: Container(
                child: Row(
                  children: [
                    if (snapshot.data!.isNotEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Column(
                            children: [
                              EntryWidget(
                                activity: snapshot.data![0],
                                position: 1,
                              ),
                              if (snapshot.data!.length >= 2)
                                EntryWidget(
                                  activity: snapshot.data![1],
                                  position: 2,
                                ),
                              if (snapshot.data!.length >= 3)
                                EntryWidget(
                                  activity: snapshot.data![2],
                                  position: 3,
                                ),
                            ],
                          ),
                        ],
                      )
                    else
                      const Center(
                        child: Text(
                          "Пока никаких активностей",
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}