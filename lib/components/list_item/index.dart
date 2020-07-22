import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_fly/models/index.dart';

SlidableController slidableController = SlidableController();

class ListItem extends StatelessWidget {
  ListItem({Key key, this.item, this.listIns, this.index}) : super(key: key);

  final Order item;
  final listIns;
  final index;
  final itemKey = GlobalKey();
  // final SlidableController slidableController = SlidableController();

  _handleTab() {
    item.id = 99999;
    listIns.refresh();
  }

  _handleDelete() {
    Slidable.of(itemKey.currentContext).dismiss();
  }

  _delete() {
    listIns.removeItem(index);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      controller: slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () {},
          closeOnTap: false,
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: _handleDelete,
          closeOnTap: false,
        ),
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        dragDismissible: false,
        onWillDismiss: (actionType) {
          return showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('提示？'),
                  content: Text('确定删除该条记录？'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('取消'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                      child: Text('确定'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              });
        },
        onDismissed: (actionType) {
          print('>>> 删除$actionType');
          _delete();
        },
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: new Color(0xFFEEEEEEE),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: _handleTab,
              child: Container(
                key: itemKey,
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('订单编号: ${item.id.toString()}'),
                    Text('未发货')
                  ],
                ),
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
      ),
    );
  }
}
