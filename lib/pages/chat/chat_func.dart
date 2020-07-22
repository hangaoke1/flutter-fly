import 'package:flutter/material.dart';
import 'package:flutter_fly/utils/fly.dart';

class ChatFunc extends StatefulWidget {
  ChatFunc({Key key}) : super(key: key);

  @override
  _ChatFuncState createState() => _ChatFuncState();
}

class _ChatFuncState extends State<ChatFunc> {
  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      color: scaffoldBackgroundColor,
      width: rpx(750),
      height: rpx(400),
      child: Text('我是扩展功能'),
    );
  }
}
