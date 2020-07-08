import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage({Key key, this.isSelf, this.child}) : super(key: key);
  bool isSelf;
  Widget child;
  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  rpx(double value) {
    return ScreenUtil.getInstance().getWidth(value);
  }

  Widget _buildMessage() {
    if (widget.isSelf) {
      return Padding(
        padding: EdgeInsets.all(rpx(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UnconstrainedBox(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 250.0, //宽度尽可能大
                  minHeight: 50.0, //最小高度为50像素
                ),
                child: Container(
                  padding: EdgeInsets.all(rpx(30)),
                  decoration: BoxDecoration(
                    color: Color(0xff52c41a),
                    borderRadius: BorderRadius.all(
                      Radius.circular(rpx(5)),
                    ),
                  ),
                  child: widget.child,
                ),
              ),
            ),
            Container(
              width: rpx(30),
              height: rpx(100),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                      left: rpx(-26),
                      top: rpx(20),
                      child: Icon(
                        Icons.arrow_right,
                        size: rpx(60),
                        color: Color(0xff52c41a),
                      ))
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.network(
                "https://pcdn.flutterchina.club/imgs/3-17.png",
                width: rpx(100),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(rpx(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.network(
                "https://pcdn.flutterchina.club/imgs/3-17.png",
                width: rpx(100),
              ),
            ),
            Container(
              width: rpx(30),
              height: rpx(100),
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                      right: rpx(-26),
                      top: rpx(20),
                      child: Icon(
                        Icons.arrow_left,
                        size: rpx(60),
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Container(
              constraints:
                  BoxConstraints(minHeight: rpx(100), maxWidth: rpx(500)),
              padding: EdgeInsets.all(rpx(30)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(rpx(5)),
                ),
              ),
              child: widget.child,
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildMessage(),
    );
  }
}
