import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef LoadCallback = Future<dynamic> Function(int pageNo, int pageSize);

typedef ItemBuilder<T> = Widget Function(
    T item, int index, List<T> list, ListWrapState listIns);

class ListWrap<Item> extends StatefulWidget {
  ListWrap({Key key, this.onLoad, this.itemBuilder, this.refresh = true})
      : super(key: key);

  final LoadCallback onLoad;

  final ItemBuilder<Item> itemBuilder;

  final bool refresh;

  ListWrapState createState() => ListWrapState<Item>();
}

class ListWrapState<Item> extends State<ListWrap>
    with AutomaticKeepAliveClientMixin {
  List<Item> list = [];
  EasyRefreshController _controller;
  int pageNo = 1;
  int pageSize = 10;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    list = [];
    _controller = EasyRefreshController();
  }

  refresh() {
    setState(() {});
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
    return EasyRefresh.custom(
      firstRefresh: true,
      firstRefreshWidget: SpinKitFadingCube(
        color: Theme.of(context).primaryColor,
        size: 40.0,
      ),
      controller: _controller,
      header: BallPulseHeader(color: Theme.of(context).primaryColor),
      footer: BallPulseFooter(color: Theme.of(context).primaryColor),
      onRefresh: _handleRefresh,
      onLoad: _handleLoad,
      scrollController: ScrollController(),
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
