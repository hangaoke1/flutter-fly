import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  Message({Key key, this.isSelf, this.child}) : super(key: key);
  final bool isSelf;
  final Widget child;
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  rpx(double value) {
    return ScreenUtil.getInstance().getWidth(value);
  }

  Widget _buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90.0),
      child: CachedNetworkImage(
        imageUrl:
            "http://wwc.alicdn.com/avatar/getAvatar.do?userNick=&width=150&height=150&type=sns&_input_charset=UTF-8",
        width: rpx(90),
        height: rpx(90),
      ),
    );
  }

  Widget _buildArrowRight() {
    return Container(
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
    );
  }

  Widget _buildArrawLeft() {
    return Container(
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
    );
  }

  Widget _buildContent() {
    return UnconstrainedBox(
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
    );
  }

  Widget _buildMessage() {
    if (widget.isSelf) {
      return Padding(
        padding: EdgeInsets.all(rpx(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildContent(),
            _buildArrowRight(),
            _buildAvatar()
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
            _buildAvatar(),
            _buildArrawLeft(),
            _buildContent(),
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
