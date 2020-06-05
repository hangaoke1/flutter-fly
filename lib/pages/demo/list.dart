import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:dio/dio.dart';

import 'package:flutter_fly/api/index.dart';
import 'package:flutter_fly/model/order.dart';
import 'list_item.dart';

class ListWrap extends StatefulWidget {
  ListWrap({Key key}) : super(key: key);

  _ListWrapState createState() => _ListWrapState();
}

class _ListWrapState extends State<ListWrap>
    with AutomaticKeepAliveClientMixin {
  List<Order> list = [];
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

  Future<dynamic> _load() async {
    print('分页参数 $pageNo $pageSize');
    Response response =
        await dio.get("http://110.80.137.93:3000/mock/200/order/list");
    String jsonStr = json.encode(response.data);
    Map<String, dynamic> jsonObj = json.decode(jsonStr);
    List resData = jsonObj['data'];
    List<Order> orderList = [];
    resData.forEach((data) {
      orderList.add(Order.fromJson(data));
    });
    pageNo += 1;
    return orderList;
  }

  Future<void> _handleRefresh() async {
    pageNo = 1;
    await Future.delayed(Duration(milliseconds: 1000));
    List<Order> orderList = await _load();
    setState(() {
      list = orderList;
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
    await Future.delayed(Duration(milliseconds: 1000));
    List<Order> orderList = await _load();
    setState(() {
      list.addAll(orderList);
    });
    _controller.finishLoad(noMore: list.length >= 30);
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
      header: BallPulseHeader(),
      footer: BallPulseFooter(),
      onRefresh: _handleRefresh,
      onLoad: _handleLoad,
      scrollController: ScrollController(),
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Order item = list[index];
              return ListItem(item: item);
            },
            childCount: list.length,
          ),
        ),
      ],
    );
  }
}
