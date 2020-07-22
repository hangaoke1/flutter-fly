import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fly/pages/home/comic/index.dart';
import 'package:flutter_fly/utils/fly.dart';
import 'package:flutter_fly/utils/theme.dart';
import 'components/product_tab.dart';
import 'components/dynamic_tab.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  List tabs = ['爆照', '鱼塘', '小天地'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtil.isDark(context);
    Color cardColor = Theme.of(context).cardColor;
    super.build(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: isDark ? Color(0xff1f1f1f) : Colors.white,
            leading: null,
            title: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BubbleTabIndicator(
                    indicatorHeight: rpx(60),
                    indicatorColor:
                        isDark ? Color(0xff9e1068) : Color(0xfff759ab),
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    indicatorRadius: rpx(30),
                  ),
                  // indicatorColor: Colors.orange,
                  // indicatorSize: TabBarIndicatorSize.label,
                  // indicatorWeight: 4,
                  // labelColor: Colors.black,
                  unselectedLabelColor: isDark ? Colors.white : Colors.black,
                  controller: _tabController,
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                  labelStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            DynamicTab(),
            ProductTab(),
            Comic(),
          ],
        ),
      ),
    );
  }
}
