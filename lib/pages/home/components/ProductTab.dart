import 'package:flutter/material.dart';
import 'package:flutter_fly/api/order.dart' as orderApi;
import 'package:flutter_fly/components/list/grid.dart';
import 'package:flutter_fly/components/u_product_card.dart';
import 'package:flutter_fly/models/order.dart';
import 'package:flutter_fly/utils/fly.dart';

class ProductTab extends StatefulWidget {
  const ProductTab({Key key}) : super(key: key);
  @override
  _ProductTabState createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab>
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
    return UProductCard(index: index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scrollbar(
      child: Container(
        padding: EdgeInsets.only(
          left: rpx(16),
          right: rpx(16),
        ),
        child: GridList<Order>(
          firstRefresh: true,
          onLoad: _load,
          itemBuilder: _buildItem,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
