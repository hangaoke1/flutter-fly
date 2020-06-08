import 'package:flutter/material.dart';
import 'package:flutter_fly/models/index.dart';

class ListItem extends StatelessWidget {

  const ListItem({Key key, this.item}) : super(key: key);

  final Order item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: new Color(0xFFEEEEEEE))
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('订单编号: ${item.id.toString()}'),
              Text('未发货')
            ],
          ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('¥ ${item.price.toStringAsFixed(2)}'),
              Text('已付款')
            ],
          )
        ],
      ),
    );
  }
}
