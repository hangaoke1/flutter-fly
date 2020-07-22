import 'package:flutter/material.dart';

class GIcon extends StatelessWidget {
  GIcon({
    Key key,
    @required this.type,
    this.size = 35,
    this.color,
  }) : super(key: key);

  final int type;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(type, fontFamily: 'Iconfont'),
      size: size,
      color: color,
    );
  }
}
