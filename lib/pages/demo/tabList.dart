import 'package:flutter/material.dart';

import 'list.dart';

class TabListDemo extends StatefulWidget {
  TabListDemo({Key key}) : super(key: key);

  _TabListDemoState createState() => _TabListDemoState();
}

class _TabListDemoState extends State<TabListDemo>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ['列表1', '列表2'];

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
            child: Text('tab测试')),
        bottom: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [ListWrap(), ListWrap()],
      ),
    );
  }
}
