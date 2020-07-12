import 'dart:async';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart'
    hide NestedScrollView, NestedScrollViewState;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter_fly/components/MyFlexibleSpaceBar.dart';
import 'package:flutter_fly/components/MySliverPersistentHeaderDelegate.dart';
import 'package:flutter_fly/components/list/index.dart';
import 'package:flutter_fly/components/listItemNormal/index.dart';
import 'package:flutter_fly/models/order.dart';
import 'package:flutter_fly/utils/theme.dart';
import 'package:flutter_fly/api/order.dart' as orderApi;

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController primaryTC;
  final GlobalKey<NestedScrollViewState> _key =
      GlobalKey<NestedScrollViewState>();
  @override
  void initState() {
    primaryTC = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    primaryTC.dispose();
    super.dispose();
  }

  rpx(double value) {
    return ScreenUtil.getInstance().getWidth(value);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    bool isDark = ThemeUtil.isDark(context);
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight = statusBarHeight + 50;
    return NestedScrollView(
      key: _key,
      headerSliverBuilder: (BuildContext c, bool f) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 50.0,
            pinned: false,
            floating: true,
            snap: true,
            centerTitle: true,
            elevation: 0.0,
            title: Text('发现'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
            flexibleSpace: MyFlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: !isDark
                  ? Image.asset(
                      'images/statistic_bg.png',
                      height: 50.0,
                      fit: BoxFit.fill,
                    )
                  : Container(
                      height: 50.0,
                      color: scaffoldBackgroundColor,
                    ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
              min: 50,
              max: 50,
              child: Container(
                decoration: !isDark
                    ? BoxDecoration(color: Colors.white)
                    : BoxDecoration(color: scaffoldBackgroundColor),
                alignment: Alignment.center,
                height: 50.0,
                child: TabBar(
                  controller: primaryTC,
                  labelColor: isDark ? Colors.white : Colors.black,
                  labelStyle:
                      TextStyle(fontSize: rpx(32), fontWeight: FontWeight.bold),
                  indicatorColor: Colors.orange,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2.0,
                  isScrollable: false,
                  tabs: const <Tab>[
                    Tab(text: '关注'),
                    Tab(text: '直播'),
                    Tab(text: '特价'),
                    Tab(text: '新品'),
                    Tab(text: '潮流'),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      pinnedHeaderSliverHeightBuilder: () {
        return pinnedHeaderHeight;
      },
      innerScrollPositionKeyBuilder: () {
        String index = 'Tab';
        index += primaryTC.index.toString();
        return Key(index);
      },
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: primaryTC,
              children: const <Widget>[
                TabViewItem(Key('Tab0')),
                TabViewItem(Key('Tab1')),
                TabViewItem(Key('Tab2')),
                TabViewItem(Key('Tab3')),
                TabViewItem(Key('Tab4')),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TabViewItem extends StatefulWidget {
  const TabViewItem(this.tabKey);
  final Key tabKey;
  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
    super.build(context);

    return NestedScrollViewInnerScrollPositionKeyWidget(
      widget.tabKey,
      ListWrap<Order>(
        firstRefresh: true,
        onLoad: _load,
        itemBuilder: _buildItem,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
