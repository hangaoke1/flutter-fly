import 'package:flutter/material.dart';
import 'package:flutter_fly/components/list/index.dart';
import 'package:flutter_fly/components/listItemNormal/index.dart';
import 'package:flutter_fly/models/order.dart';
import 'package:flutter_fly/api/order.dart' as orderApi;

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

  Future<dynamic> _load(int pageNo, int pageSize) async {
    List<Order> orderList =
        await orderApi.queryOrderList({"pageNo": pageNo, "pageSize": pageSize});
    return orderList;
  }

  Widget _buildItem(item, index, list, listIns) {
    return ListItemNormal(item: item, index: index, listIns: listIns);
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
        children: [
          ListWrap<Order>(
            onLoad: _load,
            itemBuilder: _buildItem,
          ),
          ListWrap<Order>(
            onLoad: _load,
            itemBuilder: _buildItem,
          ),
        ],
      ),
    );
  }
}
