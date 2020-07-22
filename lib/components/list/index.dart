import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_fly/components/list/refresh_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef LoadCallback = Future<dynamic> Function(int pageNo, int pageSize);

typedef ItemBuilder<T> = Widget Function(
    T item, int index, List<T> list, GListState listIns);

class GList<Item> extends StatefulWidget {
  GList({
    Key key,
    this.onLoad,
    this.itemBuilder,
    this.refresh = true,
    this.shrinkWrap = false,
    this.reverse = false,
    this.firstRefresh = false,
  }) : super(key: key);

  final LoadCallback onLoad;

  final ItemBuilder<Item> itemBuilder;

  final bool firstRefresh;

  final bool refresh;

  final bool reverse;

  final bool shrinkWrap;

  GListState createState() => GListState<Item>();
}

class GListState<Item> extends State<GList> with AutomaticKeepAliveClientMixin {
  List<Item> list = [];
  EasyRefreshController _controller;
  int pageNo = 1;
  int pageSize = 10;
  bool init = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    list = [];
    _controller = EasyRefreshController();

    /// 1. 未开启刷新
    /// 2. 首次刷新，不实用easyRefresh，因为在nestScrollView中存在跳动bug
    if (!widget.refresh || widget.firstRefresh) {
      _handleRefresh();
    }
  }

  refresh() {
    setState(() {});
  }

  insertItem(Item item) {
    setState(() {
      list.insert(0, item);
    });
  }

  removeItem(int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  Future<List<Item>> _load() async {
    print('分页参数 $pageNo $pageSize');
    List<Item> list = await widget.onLoad(pageNo, pageSize);
    pageNo += 1;
    return list;
  }

  Future<void> _handleRefresh() async {
    pageNo = 1;
    await Future.delayed(Duration(milliseconds: 1000));
    List<Item> orderList = await _load();
    if (mounted) {
      setState(() {
        init = true;
        list = orderList;
      });
    }
    _controller.resetLoadState();
    _controller.finishRefresh();
  }

  Future<void> _handleLoad() async {
    await Future.delayed(Duration(milliseconds: 1000));
    List<Item> orderList = await _load();
    setState(() {
      list.addAll(orderList);
    });
    _controller.finishLoad(noMore: orderList.length < pageSize);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.firstRefresh && !init) {
      return Center(
        child: Container(
          child: SpinKitFadingCube(
            color: Theme.of(context).primaryColor,
            size: 40.0,
          ),
        ),
      );
    } else {
      return EasyRefresh.custom(
        reverse: widget.reverse,
        shrinkWrap: widget.shrinkWrap,
        controller: _controller,
        header: RefreshUtil.getHeader(context),
        footer: RefreshUtil.getFooter(context),
        onRefresh: widget.refresh ? _handleRefresh : null,
        onLoad: _handleLoad,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final Item item = list[index];
                return widget.itemBuilder(item, index, list, this);
              },
              childCount: list.length,
            ),
          ),
        ],
      );
    }
  }
}
