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
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_fly/api/order.dart' as orderApi;

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${imgList.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

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

  Widget _getBanner() {
    return CarouselSlider(
      options: CarouselOptions(),
      items: imageSliders,
    );
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
    Color primaryColor = Theme.of(context).primaryColor;
    Color cardColor = Theme.of(context).cardColor;
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    Color shawDowColor = isDark ? Color(0xFF000000) : Color(0xFFEEEEEE);
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    TextStyle subTextStyle = Theme.of(context).textTheme.subtitle1;

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
