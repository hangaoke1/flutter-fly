import 'package:flutter/material.dart';
import 'package:flutter_fly/pages/demo/tab_bar.dart';
import 'package:flutter_fly/pages/test/banner.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

import 'list.dart';

class TabList2Demo extends StatefulWidget {
  TabList2Demo({Key key}) : super(key: key);

  _TabList2DemoState createState() => _TabList2DemoState();
}

class _TabList2DemoState extends State<TabList2Demo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs = <String>['列表1', '列表2'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
              height: 40,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text('tab2测试')),
        ),
        body: extended.NestedScrollView(
            pinnedHeaderSliverHeightBuilder: () {
              return 50;
            },
            innerScrollPositionKeyBuilder: () {
              if (_tabController.index == 0) {
                return Key('Tab0');
              } else {
                return Key('Tab1');
              }
            },
            headerSliverBuilder: (subContext, innerBoxIsScrolled) {
              return <Widget>[
                SliverPersistentHeader(
                  delegate: DemoHeader(
                      text: '足球', color: Colors.red, img: 'images/dm1@2x.png'),
                ),
                SliverPersistentHeader(
                    pinned: true, // 顶部固定
                    delegate: WeTabBar(tabs: tabs, controller: _tabController)),
              ];
            },
            body: TabBarView(controller: _tabController, children: <Widget>[
              extended.NestedScrollViewInnerScrollPositionKeyWidget(
                Key('Tab0'),
                ListWrap(),
              ),
              extended.NestedScrollViewInnerScrollPositionKeyWidget(
                Key('Tab1'),
                ListWrap(),
              )
            ])));
  }
}
