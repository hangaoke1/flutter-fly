import 'package:flutter/material.dart';
import 'package:flutter_fly/pages/demo/tab_bar.dart';
import 'package:flutter_fly/pages/test/banner.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

import 'package:flutter_fly/components/list/index.dart';
import 'package:flutter_fly/components/list_item_normal/index.dart';
import 'package:flutter_fly/models/order.dart';
import 'package:flutter_fly/api/order.dart' as orderApi;

class TabList2Demo extends StatefulWidget {
  TabList2Demo({Key key}) : super(key: key);

  _TabList2DemoState createState() => _TabList2DemoState();
}

class _TabList2DemoState extends State<TabList2Demo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs = <String>['汽车', '体育'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  Future<dynamic> _load(int pageNo, int pageSize) async {
    List<Order> orderList =
        await orderApi.queryOrderList({"pageNo": pageNo, "pageSize": pageSize});
    return orderList;
  }

  Widget _buildItem(item, index, list, listIns) {
    return ListItemNormal(item: item, index: index, listIns: listIns);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text('sliverTab')),
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
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            extended.NestedScrollViewInnerScrollPositionKeyWidget(
              Key('Tab0'),
              GList<Order>(
                onLoad: _load,
                itemBuilder: _buildItem,
              ),
            ),
            extended.NestedScrollViewInnerScrollPositionKeyWidget(
              Key('Tab1'),
              GList<Order>(
                onLoad: _load,
                itemBuilder: _buildItem,
              ),
            )
          ],
        ),
      ),
    );
  }
}
