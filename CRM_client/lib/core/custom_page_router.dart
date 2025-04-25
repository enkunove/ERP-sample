import 'package:flutter/material.dart';
class CustomPageRouter<T> extends PageRouteBuilder<T> {
  final Widget page;
  final AxisDirection direction;
  final Function? callback;
  final Duration duration;

  CustomPageRouter({
    required this.page,
    this.direction = AxisDirection.right,
    this.callback,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      late Offset begin;
      switch (direction) {
        case AxisDirection.up:
          begin = const Offset(0.0, 1.0);
          break;
        case AxisDirection.down:
          begin = const Offset(0.0, -1.0);
          break;
        case AxisDirection.left:
          begin = const Offset(1.0, 0.0);
          break;
        case AxisDirection.right:
        default:
          begin = const Offset(-1.0, 0.0);
          break;
      }

      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var slideAnimation = animation.drive(tween);

      return SlideTransition(
        position: slideAnimation,
        child: child,
      );
    },
  );
}