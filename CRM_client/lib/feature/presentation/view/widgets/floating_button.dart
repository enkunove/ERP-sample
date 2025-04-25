import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuFloatingButton extends StatefulWidget {
  final Function(int) onIconTap;
  final int selectedIndex;

  const MenuFloatingButton({
    super.key,
    required this.onIconTap,
    required this.selectedIndex,
  });

  @override
  State<MenuFloatingButton> createState() => _MenuFloatingButtonState();
}

class _MenuFloatingButtonState extends State<MenuFloatingButton> {
  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        width: containerWidth,
        decoration:  const BoxDecoration(
          color: Color(0xFF759242),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: widget.selectedIndex * (containerWidth / 3) +
                  (containerWidth / 3 - 110) / 2,
              top: -2,
              child: Container(
                child: SvgPicture.asset(
                  "lib/assets/svg/swiper.svg",
                  color: Theme.of(context).canvasColor,
                  width: 110,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (index) {
                return GestureDetector(
                  onTap: () {
                    widget.onIconTap(index);
                  },
                  child: AnimatedPadding(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.decelerate,
                    padding: EdgeInsets.only(top: widget.selectedIndex == index ? 0 : 10),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: SizedBox(
                        key: ValueKey<int>(index),
                        width: 50,
                        height: 50,
                        child: Icon(
                          _getIcon(index),
                          color: Theme.of(context).brightness == Brightness.dark? widget.selectedIndex == index
                              ? Colors.white
                              : Colors.black : Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Возвращает иконки в зависимости от индекса
  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.settings_outlined;
      case 1:
        return Icons.home_outlined;
      case 2:
        return Icons.newspaper_outlined;
      default:
        return Icons.error;
    }
  }
}