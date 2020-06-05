import 'package:flutter/material.dart';

class DemoHeader extends SliverPersistentHeaderDelegate {
  const DemoHeader({this.text, this.color, this.img});
  final String text;
  final MaterialColor color;
  final String img;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover,
          ),
        ),
        // color: color,
        alignment: Alignment.center,
        child: Text(this.text,
            style: TextStyle(color: Colors.white, fontSize: 30.0)));
  } // 头部展示内容

  @override
  double get maxExtent => 200.0; // 最大高度

  @override
  double get minExtent => 0.0; // 最小高度

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // 因为所有的内容都是固定的，所以不需要更新
}
