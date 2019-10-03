import 'package:flutter/cupertino.dart';

// 旋转缩放动画
RouteTransitionsBuilder scaleRotateAni = (BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return new ScaleTransition(
    scale: animation,
    child: new RotationTransition(
      turns: animation,
      child: child,
    ),
  );
};

// 缩放动画
RouteTransitionsBuilder scaleAni = (BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return ScaleTransition(
    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animation,
      curve: Cubic(0.36, 0.66, 0.04, 1),
    )),
    child: child,
  );
};
