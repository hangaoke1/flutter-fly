import 'package:flutter/material.dart';
import 'package:flutter_fly/api/order.dart' as orderApi;
import 'package:flutter_fly/components/UserDynamic.dart';
import 'package:flutter_fly/components/list/index.dart';
import 'package:flutter_fly/models/order.dart';

class DynamicTab extends StatefulWidget {
  const DynamicTab({Key key}) : super(key: key);
  @override
  _DynamicTabState createState() => _DynamicTabState();
}

class _DynamicTabState extends State<DynamicTab>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> _load(int pageNo, int pageSize) async {
    List<Order> orderList =
        await orderApi.queryOrderList({"pageNo": pageNo, "pageSize": pageSize});
    return orderList;
  }

  Widget _buildItem(item, index, list, listIns) {
    return UserDynamic(id: item.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scrollbar(
      child: ListWrap<Order>(
        firstRefresh: true,
        onLoad: _load,
        itemBuilder: _buildItem,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
