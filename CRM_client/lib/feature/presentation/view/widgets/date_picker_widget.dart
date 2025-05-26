import 'package:flutter/cupertino.dart';

class DatePickerRow extends StatelessWidget {
  final int day;
  final int month;
  final int year;
  final bool isWhite;
  final Function(int, int) onDateChanged;

  const DatePickerRow({super.key,
    required this.day,
    required this.month,
    required this.year,
    required this.onDateChanged, required this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(width: 20,),
        Expanded(
          child: CupertinoPicker(
            itemExtent: 40,
            scrollController: FixedExtentScrollController(initialItem: day - 1),
            onSelectedItemChanged: (index) {
              onDateChanged(0, index + 1);
            },
            children: List<Widget>.generate(31, (index) {
              return Center(
                child: Text(
                    '${index + 1}',
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            itemExtent: 40,
            scrollController: FixedExtentScrollController(initialItem: month - 1),
            onSelectedItemChanged: (index) {
              onDateChanged(1, index + 1);
            },
            children: List<Widget>.generate(12, (index) {
              return Center(
                child: Text(
                    '${index + 1}',
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: CupertinoPicker(
            itemExtent: 40,
            scrollController: FixedExtentScrollController(initialItem: year - 1930),
            onSelectedItemChanged: (index) {
              onDateChanged(2, 1930 + index);
            },
            children: List<Widget>.generate(
              DateTime.now().year - 1930 + 1,
                  (index) {
                return Center(
                  child: Text(
                      '${1930 + index}',
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 20,)
      ],
    );
  }
}