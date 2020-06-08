import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_fly/components/list/index.dart';
import 'package:flutter_fly/pages/demo/list_item.dart';

import 'package:flutter_fly/api/order.dart' as orderApi;
import 'package:flutter_fly/models/index.dart';

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
    List<Order> orderList = await orderApi.queryOrderList({
      pageNo: pageNo,
      pageSize: pageSize
    });
    return orderList;
  }

  Widget _build(item) {
    return ListItem(item: item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('列表加载'), elevation: 0.5),
        body: ListWrap<Order>(
          onLoad: _load,
          itemBuilder: _build,
        ));
  }
}
