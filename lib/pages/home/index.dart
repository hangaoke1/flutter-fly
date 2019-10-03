import 'package:flutter/material.dart';
import 'package:hello_world/pages/home/comic/index.dart';
import 'package:hello_world/pages/home/movie/index.dart';
import 'package:hello_world/pages/home/story/index.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ['电影', '漫画', '小说'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TabBar(
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList(),
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          )
        ),
        body: TabBarView(
          controller: _tabController,
          children: [Movie(), Comic(), Story()],
        ),
      ),
    );
  }
}
