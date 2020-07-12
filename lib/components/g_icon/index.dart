import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GIcon extends StatelessWidget {
  GIcon({
    Key key,
    @required this.type,
    this.size = 35,
    this.color,
  }) : super(key: key);

  int type;
  double size;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(type, fontFamily: 'Iconfont'),
      size: size,
      color: color,
    );
  }
}
