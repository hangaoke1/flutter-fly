import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:hello_world/pages/test/banner.dart';

import 'list_item.dart';

class ListWrap extends StatefulWidget {
  ListWrap({Key key}) : super(key: key);

  _ListWrapState createState() => _ListWrapState();
}

class _ListWrapState extends State<ListWrap>
    with AutomaticKeepAliveClientMixin {
  List<String> list = <String>[];
  EasyRefreshController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    list = ['a', 'b', 'c', 'd'];
    _controller = EasyRefreshController();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      List<String> newList =
          List.generate(5, (int index) => '刷' + index.toString());
      list = newList;
    });
    Fluttertoast.showToast(
        msg: "刷新完成",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: const Color(0x80000000),
        textColor: Colors.white,
        fontSize: 16.0);
    _controller.resetLoadState();
    _controller.finishRefresh();
  }

  Future<void> _handleLoad() async {
    await Future.delayed(Duration(milliseconds: 2000));
    print('加载更多');
    if (!mounted) return;
    int len = list.length;
    List<String> newList =
        List.generate(10, (int index) => '加' + (len + index).toString());
    setState(() {
      list.addAll(newList);
    });
    _controller.finishLoad(noMore: list.length >= 30);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh.custom(
      controller: _controller,
      header: BallPulseHeader(),
      footer: BallPulseFooter(),
      onRefresh: _handleRefresh,
      onLoad: _handleLoad,
      slivers: <Widget>[
        // SliverPersistentHeader(
        //   delegate: DemoHeader(
        //       text: '足球', color: Colors.red, img: 'images/dm1@2x.png'),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final String item = list[index];
              return ListItem(item: item);
            },
            childCount: list.length,
          ),
        ),
      ],
    );
  }
}
