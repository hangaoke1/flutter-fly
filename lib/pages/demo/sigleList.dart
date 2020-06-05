import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:flutter_fly/api/index.dart';
import 'package:flutter_fly/model/order.dart';

import 'package:flutter_fly/components/list/index.dart';
import 'package:flutter_fly/pages/demo/list_item.dart';

class SingleListDemo extends StatefulWidget {
  SingleListDemo({Key key}) : super(key: key);

  _SingleListDemoState createState() => _SingleListDemoState();
}

class _SingleListDemoState extends State<SingleListDemo> {
  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> _load(int pageNo, int pageSize) async {
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
    return orderList;
  }

  Widget _build(item) {
    return ListItem(item: item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('列表加载233'), elevation: 0.5),
        body: ListWrap<Order>(
          onLoad: _load,
          itemBuilder: _build,
        ));
  }
}
