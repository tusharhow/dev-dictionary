import 'package:flutter/material.dart';

SlideTransition slideTransition(
  Animation<double> animation,
  Widget child,
) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  const curve = Curves.ease;
  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  var offsetAnimation = animation.drive(tween);
  return SlideTransition(position: offsetAnimation, child: child);
}
