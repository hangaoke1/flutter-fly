import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'banner.dart';

// 视差滚动
class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverPersistentHeader(
          // pinned: true, // 顶部固定
          // floating: true, // 下拉后立即开始显示
          delegate: DemoHeader(
              text: '足球', color: Colors.red, img: 'images/dm1@2x.png'),
        ),
        SliverPersistentHeader(
          delegate: DemoHeader(
              text: '篮球', color: Colors.blue, img: 'images/dm2@2x.png'),
        ),
        SliverPersistentHeader(
          delegate: DemoHeader(
              text: '电影', color: Colors.indigo, img: 'images/dm3@2x.png'),
        ),
        SliverPersistentHeader(
          delegate: DemoHeader(
              text: '漫画', color: Colors.blue, img: 'images/dm4@2x.png'),
        ),
        SliverPersistentHeader(
          delegate: DemoHeader(
              text: '小说', color: Colors.indigo, img: 'images/dm1@2x.png'),
        ),
        SliverPersistentHeader(
          delegate: DemoHeader(
              text: '动漫', color: Colors.blue, img: 'images/dm2@2x.png'),
        ),
        SliverPersistentHeader(
          delegate: DemoHeader(
              text: '直播', color: Colors.lime, img: 'images/dm3@2x.png'),
        ),
        SliverFillRemaining(
          // 剩余补充内容TabBarView
          child: Center(child: Text('更多敬请期待')),
        ),
      ],
    );
  }
}

class StickyTabBarDelegate {}
