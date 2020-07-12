import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
              borderRadius: BorderRadius.circular(90.0),
              child: CachedNetworkImage(
                imageUrl:
                    "http://wwc.alicdn.com/avatar/getAvatar.do?userNick=&width=150&height=150&type=sns&_input_charset=UTF-8",
                width: rpx(90),
                height: rpx(90),
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
              borderRadius: BorderRadius.circular(90.0),
              child: CachedNetworkImage(
                imageUrl:
                    "http://wwc.alicdn.com/avatar/getAvatar.do?userNick=&width=150&height=150&type=sns&_input_charset=UTF-8",
                width: rpx(90),
                height: rpx(90),
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
