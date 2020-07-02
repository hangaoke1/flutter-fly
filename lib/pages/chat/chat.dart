import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_fly/components/list/index.dart';
import 'package:flutter_fly/components/listItem/index.dart';
import 'package:flutter_fly/api/order.dart' as orderApi;
import 'package:flutter_fly/models/index.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<int> top = [];
  List<int> bottom = [];
  bool _loading = false;
  bool _nomore = false;

  final ScrollController _scroller = ScrollController(
    initialScrollOffset: 0,
  );

  void initState() {
    _scroller.addListener(() {
      // 用户滚动距离
      final double offset = _scroller.position.pixels;
      // 顶部距离
      final double min = _scroller.position.minScrollExtent;
      // 触发历史消息加载
      if (offset - min < 20 && !_loading && !_nomore) {
        _loadHistory();
      } else {
        print('>>> 不满足');
      }
    });
    _initChatList();
    super.initState();
  }

  @override
  void dispose() {
    // 移除监听器
    _scroller.dispose();
    super.dispose();
  }

  _initChatList() {
    setState(() {
      bottom = List<int>.generate(10, (i) => i + 1);
    });
    _scrollToBottom(offset: 0, milliseconds: 0);
  }

  Future<void> _loadHistory() async {
    setState(() {
      _loading = true;
    });
    HapticFeedback.mediumImpact();
    Timer(
      const Duration(milliseconds: 1000),
      () {
        addItems();
        setState(() {
          _loading = false;
        });
      },
    );
    return;
  }

  void addItems() {
    setState(() {
      final List<int> a = <int>[];
      for (var i = 0; i < 3; i++) {
        a.add(-top.length - i);
      }
      top.addAll(a);
    });
  }

  void addItems2() {
    setState(() {
      final List<int> a = <int>[];
      for (var i = 0; i < 3; i++) {
        a.add(bottom.length + i);
      }
      bottom.addAll(a);
    });
    _scrollToBottom();
  }

  void _scrollToBottom({double offset = 0, int milliseconds = 300}) {
    // ignore: always_specify_types
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (milliseconds == 0) {
        _scroller.jumpTo(
          _scroller.position.maxScrollExtent - 40,
        );
      } else {
        _scroller.animateTo(
          _scroller.position.maxScrollExtent + offset,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: always_specify_types
    const Key centerKey = ValueKey('second-sliver-list');
    return Scaffold(
        appBar: AppBar(
          title: const Text('ChatList'),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: CustomScrollView(
            controller: _scroller,
            physics: const ClampingScrollPhysics(),
            center: centerKey,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (_loading && index == top.length) {
                      return Container(
                        alignment: Alignment.center,
                        height: 100.0,
                        child: Text('加载中...'),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.green[200 + top[index] % 4 * 100],
                        height: 100 + top[index] % 4 * 20.0,
                        child: Text('Item: ${top[index]}'),
                      );
                    }
                  },
                  childCount: _loading ? top.length + 1 : top.length,
                ),
              ),
              SliverList(
                key: centerKey,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.green[200 + bottom[index] % 4 * 100],
                      height: 100 + bottom[index] % 4 * 20.0,
                      child: Text('Item: ${bottom[index]}'),
                    );
                  },
                  childCount: bottom.length,
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: <Widget>[
          FloatingActionButton(
            onPressed: addItems,
            heroTag: 'first',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _scrollToBottom,
            heroTag: 'sub',
            child: Icon(Icons.arrow_drop_down),
          )
        ]);
  }
}
