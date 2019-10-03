import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeTabBar extends SliverPersistentHeaderDelegate {
  const WeTabBar({this.color, this.tabs, this.controller});
  final MaterialColor color;
  final List<String> tabs;
  final TabController controller;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        alignment: Alignment.center,
        child: TabBar(
            controller: controller,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            labelColor: Colors.red
        )
      );
  } // 头部展示内容

  @override
  double get maxExtent => 50.0; // 最大高度

  @override
  double get minExtent => 50.0; // 最小高度

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // 因为所有的内容都是固定的，所以不需要更新
}
