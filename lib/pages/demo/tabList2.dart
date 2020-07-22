import 'dart:async';

import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:flutter_fly/components/list/index.dart';
import 'package:flutter_fly/components/list_item/index.dart';
import 'package:flutter_fly/models/order.dart';
import 'package:flutter_fly/api/order.dart' as orderApi;

/// NestedScrollView示例页面
class TabList2Demo extends StatefulWidget {
  @override
  TabList2DemoState createState() {
    return TabList2DemoState();
  }
}

class TabList2DemoState extends State<TabList2Demo>
    with SingleTickerProviderStateMixin {
  // 滚动控制器
  ScrollController _scrollController;
  // Tab控制器
  TabController _tabController;
  int _tabIndex = 0;
  // 初始化
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  Future<dynamic> _load(int pageNo, int pageSize) async {
    List<Order> orderList =
        await orderApi.queryOrderList({"pageNo": pageNo, "pageSize": pageSize});
    return orderList;
  }

  Widget _buildItem(item, index, list, listIns) {
    return ListItem(item: item, index: index, listIns: listIns);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: extended.NestedScrollView(
        pinnedHeaderSliverHeightBuilder: () {
          return MediaQuery.of(context).padding.top + kToolbarHeight + 30;
        },
        innerScrollPositionKeyBuilder: () {
          if (_tabController.index == 0) {
            return Key('Tab0');
          } else {
            return Key('Tab1');
          }
        },
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              title: Text("NestedScrollView"),
              centerTitle: true,
              expandedHeight: 190.0,
              flexibleSpace: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(),
              ),
              floating: false,
              pinned: true,
              bottom: new PreferredSize(
                child: new Card(
                  color: Theme.of(context).primaryColor,
                  elevation: 0.0,
                  margin: new EdgeInsets.all(0.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  ),
                  child: new TabBar(
                    controller: _tabController,
                    onTap: (index) {
                      setState(() {
                        _tabIndex = index;
                      });
                    },
                    tabs: <Widget>[
                      new Tab(
                        text: 'List',
                      ),
                      new Tab(
                        text: 'Grid',
                      ),
                    ],
                  ),
                ),
                preferredSize: new Size(double.infinity, 46.0),
              ),
            ),
          ];
        },
        body: IndexedStack(
          index: _tabIndex,
          children: <Widget>[
            extended.NestedScrollViewInnerScrollPositionKeyWidget(
              Key('Tab0'),
              GList<Order>(
                firstRefresh: true,
                onLoad: _load,
                itemBuilder: _buildItem,
              ),
            ),
            extended.NestedScrollViewInnerScrollPositionKeyWidget(
              Key('Tab1'),
              GList<Order>(
                firstRefresh: true,
                onLoad: _load,
                itemBuilder: _buildItem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
