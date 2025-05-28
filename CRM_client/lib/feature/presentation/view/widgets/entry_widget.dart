import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/activity.dart';

class EntryWidget extends StatelessWidget {
  final Activity activity;
  final int position;
  const EntryWidget(
      {super.key, required this.activity, required this.position});

  @override
  Widget build(BuildContext context) {
    double opacityFactor = 1.0 - (position - 1) * 0.3;
    opacityFactor = opacityFactor < 0.2 ? 0.2 : opacityFactor;

    return Center(
      child: Builder(
        builder: (context) {
          double screenWidth = MediaQuery.of(context).size.width - 40;
          double containerWidth;

          if (position == 1) {
            containerWidth = screenWidth;
          } else if (position == 2) {
            containerWidth = screenWidth - 20;
          } else {
            containerWidth = screenWidth - 40;
          }

          return Container(
            width: containerWidth,
            height: 64,
            decoration: BoxDecoration(
              border: Border.all(
                width: 5.0,
                color: Theme.of(context).canvasColor,
              ),
              borderRadius: BorderRadius.circular(10),
              gradient: position == 1
                  ? const LinearGradient(
                colors: [
                  Color(0x88374709),
                  Color(0xFF374709),
                  Color(0x88374709)
                ],
                stops: [0.0, 0.5, 1.0],
              )
                  : position == 2
                  ? const LinearGradient(
                colors: [
                  Color(0x33374709),
                  Color(0xAA374709),
                  Color(0x33374709),
                ],
                stops: [0.0, 0.5, 1.0],
              )
                  : const LinearGradient(
                colors: [
                  Color(0x00374709),
                  Color(0x55374709),
                  Color(0x00374709),

                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                padding: const EdgeInsets.all(2),
                width: containerWidth - 4,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).canvasColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: opacityFactor,
                      child: const Icon(Icons.directions_walk)
                    ),
                    Opacity(
                      opacity: opacityFactor,
                      child: Text(
                        activity.itemType,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).brightness ==
                              Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      )
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Opacity(
                          opacity: opacityFactor,
                          child: Text(
                            DateFormat("dd.MM.yyyy").format(activity.date),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: opacityFactor,
                          child: Text(
                            DateFormat("HH:mm").format(activity.date),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              fontSize: 12,
                              color: const Color(0xFF374709),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}